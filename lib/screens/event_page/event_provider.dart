import 'dart:developer';

import 'package:eventistan/models/event_model.dart';
import 'package:eventistan/providers/events_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final eventProvider =
    StateNotifierProvider.family<EventNotifier, EventState, String>((ref, id) {
  final eventsRepository = ref.read(eventsRepositoryProvider);
  return EventNotifier(
    eventsRepository: eventsRepository,
    eventId: id,
  );
});

class EventNotifier extends StateNotifier<EventState> {
  final EventsRepository eventsRepository;
  final String eventId;

  EventNotifier({
    required this.eventsRepository,
    required this.eventId,
  }) : super(EventState()) {
    onLoad();
  }

  setLoading(bool value) {
    state = state.copyWith(
      isLoading: value,
    );
  }

  onLoad() async {
    setLoading(true);
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      // Check location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final event = await eventsRepository.getEventById(
        id: eventId,
        userLat: position.latitude,
        userLng: position.longitude,
      );

      state = state.copyWith(
        event: event,
        isLoading: false,
      );
    } catch (e, s) {
      setLoading(false);
      log(
        "Error fetching event details. ",
        error: e,
        stackTrace: s,
      );
    }
  }
}

class EventState {
  Event? event;
  bool isLoading;
  String error;

  EventState({
    this.event,
    this.isLoading = false,
    this.error = '',
  });

  EventState copyWith({
    Event? event,
    bool? isLoading,
    String? error,
  }) {
    return EventState(
      event: event ?? this.event,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
