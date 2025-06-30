import 'dart:convert';
import 'dart:developer';
import 'package:eventistan/models/ticket_model.dart';
import 'package:eventistan/providers/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentRepositoryProvider = StateProvider((ref) {
  final apiService = ref.read(apiProvider);
  return PaymentRepository(apiService, ref);
});

class PaymentRepository {
  late APIService apiService;
  final Ref ref;

  PaymentRepository(this.apiService, this.ref);

  Future<String> createPaymentIntent({
    required String eventId,
    required int quantity,
  }) async {
    try {
      final body = jsonEncode({
        "eventId": eventId,
        "quantity": quantity,
      });

      final response = await apiService.post(
        endpoint: '/api/payments/create-payment-intent',
        body: body,
      );

      if (response.statusCode == 200) {
        final clientSecret = response.data['clientSecret'];
        return clientSecret;
      } else {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<void> purchaseTicket({
    required String paymentIntentId,
    required String eventId,
    required String userId,
    required int quantity,
  }) async {
    try {
      final body = jsonEncode({
        "paymentIntentId": paymentIntentId,
        "eventId": eventId,
        "userId": userId,
        "quantity": quantity,
      });

      final response = await apiService.post(
        endpoint: '/api/tickets/purchase',
        body: body,
      );

      if (response.statusCode != 200) {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<List<Ticket>> getUserTickets({required String userId}) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/tickets/user/$userId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((x) => Ticket.fromJson(x)).toList();
      } else {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e, s) {
      log(
        "Unable to fetch purchased tickets. ",
        error: e,
        stackTrace: s,
      );
      throw e.toString();
    }
  }

  Future<void> refundTicket({
    required String ticketId,
  }) async {
    try {
      final body = jsonEncode({
        "ticketId": ticketId,
      });

      final response = await apiService.post(
        endpoint: '/api/tickets/refund',
        body: body,
      );

      if (response.statusCode != 200) {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }
}
