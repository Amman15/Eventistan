import 'package:dio/dio.dart';
import 'package:eventistan/services/dio_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      responseType: ResponseType.json,
    ),
  );
  dio.interceptors.add(
    DioInterceptor(ref),
  );
  return dio;
});
