import 'package:eventistan/providers/user_repo_provider.dart';
import 'package:eventistan/screens/user_type_page.dart';
import 'package:eventistan/screens/login_type/login_type_widget.dart';
import 'package:eventistan/services/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventistan/providers/token_provider.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  void initState() {
    FCMConfig.initializeFCM();
    super.initState();
  }

  _updateFCMToken() async {
    final userRepository = ref.watch(userRepositoryProvider);
    String? token = await FCMConfig.getFCMToken();
    if (token != null) {
      await userRepository.patchUser(
        fcmToken: token,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.watch(tokenProvider);

    if (token != '') {
      _updateFCMToken();
      return const UserTypePage();
    } else {
      return const LoginTypeWidget();
    }
  }
}
