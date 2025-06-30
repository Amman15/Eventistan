import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/constants.dart';
import 'dio_provider.dart';

final apiProvider = StateProvider((ref) => APIService(ref));

class APIService {
  static String baseUrl = server;
  final Ref ref;
  late final Dio dio;

  APIService(this.ref) {
    dio = ref.read(dioProvider);
  }

  Future<Response> get({required String endpoint}) async {
    return await dio.get(
      '$baseUrl$endpoint',
    );
  }

  Future<Response> post({required String endpoint, String? body}) async {
    return await dio.post(
      '$baseUrl$endpoint',
      data: body,
    );
  }

  Future<Response> put({required String endpoint, String? body}) async {
    return await dio.put(
      '$baseUrl$endpoint',
      data: body,
    );
  }

  Future<Response> patch({required String endpoint, String? body}) async {
    return await dio.patch(
      '$baseUrl$endpoint',
      data: body,
    );
  }

  Future<Response> delete({required String endpoint}) async {
    return await dio.delete(
      '$baseUrl$endpoint',
    );
  }
}
