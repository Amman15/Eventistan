import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eventistan/providers/token_provider.dart';

final dioInterceptorProvider = Provider((ref) => DioInterceptor(ref));

class DioInterceptor extends Interceptor {
  final Ref ref;

  DioInterceptor(this.ref);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add the authentication header to the outgoing request
    final String token = ref.read(tokenProvider);

    options.headers['Authorization'] = 'Bearer $token';

    options.headers['Content-Type'] = 'application/json';

    // Log the details of the outgoing request
    log('Sending request to ${options.uri}');
    log('Method: ${options.method}');
    log('Headers: ${jsonEncode(options.headers)}');
    if (options.data != null) {
      log('Body: ${json.encode(options.data)}');
    }
    if (options.queryParameters.isNotEmpty) {
      log('Query Parameters: ${options.queryParameters}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log the details of the incoming response
    log('Received response from ${response.requestOptions.uri}');
    log('Status Code: ${response.statusCode}');

    if (response.statusCode == 401) {
      ref.read(tokenProvider.notifier).setToken('');
    }

    if (response.data != null) {
      log('Response Body: ${response.data}');
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log the details of the error
    log('Error sending request to ${err.requestOptions.uri}');
    if (err.response != null) {
      log('Status Code: ${err.response!.statusCode}');

      if (err.response!.statusCode == 401) {
        ref.read(tokenProvider.notifier).setToken('');
      }

      if (err.response!.data != null) {
        log('Response Body: ${err.response!.data}');

        Fluttertoast.showToast(
          msg: err.response!.data['message'],
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (!err.response!.headers.isEmpty) {
        log('Headers: ${err.response!.headers}');
      }
    }

    log('Error type: ${err.type}');
    log('Error message: ${err.message}');

    super.onError(err, handler);
  }
}
