import 'package:eventistan/index.dart';
import 'package:eventistan/providers/future_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserTypePage extends ConsumerWidget {
  const UserTypePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final user = ref.watch(userProvider);

          return user.when(
            data: (data) {
              if (data.role == 'Attendee') {
                return const HomeWidget();
              } else {
                return const OrganizerHomeWidget();
              }
            },
            error: (error, stackTrace) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
