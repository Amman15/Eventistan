import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class EventRecord extends FirestoreRecord {
  EventRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "event_name" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  bool hasEventName() => _eventName != null;

  // "venue" field.
  String? _venue;
  String get venue => _venue ?? '';
  bool hasVenue() => _venue != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "start_time" field.
  String? _startTime;
  String get startTime => _startTime ?? '';
  bool hasStartTime() => _startTime != null;

  // "event_logo" field.
  String? _eventLogo;
  String get eventLogo => _eventLogo ?? '';
  bool hasEventLogo() => _eventLogo != null;

  void _initializeFields() {
    _eventName = snapshotData['event_name'] as String?;
    _venue = snapshotData['venue'] as String?;
    _description = snapshotData['description'] as String?;
    _startTime = snapshotData['start_time'] as String?;
    _eventLogo = snapshotData['event_logo'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('event');

  static Stream<EventRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventRecord.fromSnapshot(s));

  static Future<EventRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventRecord.fromSnapshot(s));

  static EventRecord fromSnapshot(DocumentSnapshot snapshot) => EventRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventRecordData({
  String? eventName,
  String? venue,
  String? description,
  String? startTime,
  String? eventLogo,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'event_name': eventName,
      'venue': venue,
      'description': description,
      'start_time': startTime,
      'event_logo': eventLogo,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventRecordDocumentEquality implements Equality<EventRecord> {
  const EventRecordDocumentEquality();

  @override
  bool equals(EventRecord? e1, EventRecord? e2) {
    return e1?.eventName == e2?.eventName &&
        e1?.venue == e2?.venue &&
        e1?.description == e2?.description &&
        e1?.startTime == e2?.startTime &&
        e1?.eventLogo == e2?.eventLogo;
  }

  @override
  int hash(EventRecord? e) => const ListEquality().hash(
      [e?.eventName, e?.venue, e?.description, e?.startTime, e?.eventLogo]);

  @override
  bool isValidKey(Object? o) => o is EventRecord;
}
