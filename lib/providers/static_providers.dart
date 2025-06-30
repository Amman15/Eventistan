import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceProvider = FutureProvider(
  (ref) async => SharedPreferences.getInstance(),
);

final bottomNavBarSelectedIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final overviewTabSelectedIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final citySelectorProvider = StateProvider<String>((ref) {
  return '';
});

final eventTypeSelectorProvider = StateProvider<String>((ref) {
  return '';
});

final loadingProvider = StateProvider<bool>((ref) => false);
