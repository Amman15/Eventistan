import 'dart:convert';
import 'dart:developer';
import 'package:eventistan/models/event_model.dart';
import 'package:eventistan/providers/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventsRepositoryProvider = StateProvider((ref) {
  final apiService = ref.read(apiProvider);
  return EventsRepository(apiService, ref);
});

class EventsRepository {
  late APIService apiService;
  final Ref ref;

  EventsRepository(this.apiService, this.ref);

  Future<List<Event>> searchEvents({
    String? searchQuery,
    String? city,
    String? eventType,
    required String userLat,
    required String userLng,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/events/search?'
            '${searchQuery != null && searchQuery.isNotEmpty ? "query=$searchQuery&" : ""}'
            '${city != null && city.isNotEmpty ? "city=$city&" : ""}'
            '${eventType != null && eventType.isNotEmpty ? "type=$eventType&" : ""}'
            'userLat=$userLat&userLng=$userLng',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((x) => Event.fromJson(x)).toList();
      } else {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<List<Event>> getUpcomingEvents({required String organizerId}) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/events/upcoming/$organizerId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((x) => Event.fromJson(x)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log(
        "Error fetching upcoming events. ",
        error: e,
        stackTrace: s,
      );

      return [];
    }
  }

  Future<List<Event>> getPastEvents({required String organizerId}) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/events/past/$organizerId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((x) => Event.fromJson(x)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log(
        "Error fetching past events. ",
        error: e,
        stackTrace: s,
      );

      return [];
    }
  }

  Future<Event> createEvent({
    required String name,
    required String venue,
    required String date,
    required String description,
    required String organizer,
    required String eventLogo,
    required String price,
    required String eventType,
    required Map<String, double> coordinates,
  }) async {
    try {
      final body = jsonEncode({
        'name': name,
        'venue': venue,
        'date': date,
        'description': description,
        'organizer': organizer,
        'eventLogo': eventLogo,
        'price': price,
        'eventType': eventType,
        'coordinates': coordinates,
      });

      final response = await apiService.post(
        endpoint: '/api/events/',
        body: body,
      );

      if (response.statusCode == 200) {
        final event = Event.fromJson(response.data);
        return event;
      } else {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<Event> getEventById({
    required String id,
    required double userLat,
    required double userLng,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/events/$id?userLat=$userLat&userLng=$userLng',
      );

      if (response.statusCode == 200) {
        final event = Event.fromJson(response.data['data']);
        return event;
      } else {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<List<Event>> getEventRecommendations({
    required String userId,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/events/recommendations/$userId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((x) => Event.fromJson(x)).toList();
      } else {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }
}
