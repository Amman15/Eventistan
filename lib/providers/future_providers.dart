import 'package:eventistan/models/event_model.dart';
import 'package:eventistan/models/ticket_model.dart';
import 'package:eventistan/models/user_model.dart';
import 'package:eventistan/providers/events_repo_provider.dart';
import 'package:eventistan/providers/payment_repo_provider.dart';
import 'package:eventistan/providers/static_providers.dart';
import 'package:eventistan/providers/user_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = FutureProvider<User>((ref) async {
  final userRepository = ref.read(userRepositoryProvider);
  return await userRepository.getUser();
});

final eventsProvider = FutureProvider<List<Event>>((ref) async {
  final eventsRepository = ref.read(eventsRepositoryProvider);

  final searchQuery = ref.watch(searchQueryProvider);
  final citySelector = ref.watch(citySelectorProvider);
  final eventType = ref.watch(eventTypeSelectorProvider);

  return await eventsRepository.searchEvents(
    searchQuery: searchQuery,
    city: citySelector,
    eventType: eventType,
    userLat: '31.520370',
    userLng: '74.358749',
  );
});

final ticketsProvider =
    FutureProvider.autoDispose.family<List<Ticket>, String>((ref, id) async {
  final paymentRepository = ref.read(paymentRepositoryProvider);
  return await paymentRepository.getUserTickets(
    userId: id,
  );
});

final upcomingEventsProvider =
    FutureProvider.autoDispose.family<List<Event>, String>((ref, id) async {
  final eventsRepository = ref.read(eventsRepositoryProvider);
  return await eventsRepository.getUpcomingEvents(
    organizerId: id,
  );
});

final pastEventsProvider =
    FutureProvider.autoDispose.family<List<Event>, String>((ref, id) async {
  final eventsRepository = ref.read(eventsRepositoryProvider);
  return await eventsRepository.getPastEvents(
    organizerId: id,
  );
});
