import 'package:eventistan/providers/events_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventistan/models/event_model.dart';
import 'dart:developer';

final recommendedEventsProvider = StateNotifierProvider.family<
    RecommendedEventsNotifier, RecommendedEventsState, String>((ref, id) {
  final eventsRepository = ref.read(eventsRepositoryProvider);
  return RecommendedEventsNotifier(
    eventsRepository: eventsRepository,
    userId: id,
  );
});

class RecommendedEventsNotifier extends StateNotifier<RecommendedEventsState> {
  final EventsRepository eventsRepository;
  final String userId;

  RecommendedEventsNotifier({
    required this.eventsRepository,
    required this.userId,
  }) : super(RecommendedEventsState()) {
    loadRecommendedEvents();
  }

  Future<void> loadRecommendedEvents() async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      final events = await eventsRepository.getEventRecommendations(
        userId: userId,
      );

      state = state.copyWith(
        isLoading: false,
        events: events,
      );
    } catch (e) {
      log(e.toString());
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

class RecommendedEventsState {
  final bool isLoading;
  final List<Event> events;
  final String? error;

  RecommendedEventsState({
    this.isLoading = false,
    this.events = const [],
    this.error,
  });

  RecommendedEventsState copyWith({
    bool? isLoading,
    List<Event>? events,
    String? error,
  }) {
    return RecommendedEventsState(
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      error: error ?? this.error,
    );
  }
}
