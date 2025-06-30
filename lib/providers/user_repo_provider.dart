import 'dart:convert';
import 'dart:developer';
import 'package:eventistan/models/user_model.dart';
import 'package:eventistan/providers/api_provider.dart';
import 'package:eventistan/providers/token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = StateProvider((ref) {
  final apiService = ref.read(apiProvider);

  return UserRepository(apiService, ref);
});

class UserRepository {
  late APIService apiService;
  final Ref ref;

  UserRepository(this.apiService, this.ref);

  Future<User> loginWithEmail({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final body = jsonEncode({
        "email": email,
        "password": password,
        "role": role,
      });

      final response = await apiService.post(
        endpoint: '/api/users/login',
        body: body,
      );

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['data']);

        ref
            .read(tokenProvider.notifier)
            .setToken(response.data['data']['token']);

        return user;
      } else {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<User> signupWithEmail({
    required String email,
    required String password,
    required String type,
  }) async {
    try {
      final body = jsonEncode({
        "email": email,
        "password": password,
        "role": type,
      });

      final response = await apiService.post(
        endpoint: '/api/users/register',
        body: body,
      );

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['data']);
        return user;
      } else {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<User> getUser() async {
    try {
      final response = await apiService.get(
        endpoint: '/api/users/profile',
      );

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['data']);

        return user;
      } else {
        log(response.data['message']);
        throw response.data['message'];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<User> patchUser({
    String? name,
    String? email,
    String? password,
    String? profilePicture,
    String? age,
    String? city,
    String? bio,
    String? phone,
    String? teamSize,
    String? teamName,
    String? fcmToken,
  }) async {
    try {
      final body = jsonEncode({
        if (name != null) "name": name,
        if (email != null) "email": email,
        if (password != null) "password": password,
        if (profilePicture != null) "profilePicture": profilePicture,
        if (age != null) "age": age,
        if (city != null) "city": city,
        if (bio != null) "bio": bio,
        if (phone != null) "phone": phone,
        if (teamSize != null) "teamSize": teamSize,
        if (teamName != null) "teamName": teamName,
        if (fcmToken != null) "fcmToken": fcmToken,
      });

      final response = await apiService.put(
        endpoint: '/api/users/profile',
        body: body,
      );

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['data']);

        return user;
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
