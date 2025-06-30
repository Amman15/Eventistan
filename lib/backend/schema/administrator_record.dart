import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdministratorRecord extends FirestoreRecord {
  AdministratorRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "age" field.
  int? _age;
  int get age => _age ?? 0;
  bool hasAge() => _age != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _email = snapshotData['email'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _age = castToType<int>(snapshotData['age']);
    _phoneNumber = snapshotData['phone_number'] as String?;
    _password = snapshotData['password'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Administrator');

  static Stream<AdministratorRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdministratorRecord.fromSnapshot(s));

  static Future<AdministratorRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AdministratorRecord.fromSnapshot(s));

  static AdministratorRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdministratorRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdministratorRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdministratorRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdministratorRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdministratorRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdministratorRecordData({
  String? name,
  String? email,
  String? photoUrl,
  int? age,
  String? phoneNumber,
  String? password,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'email': email,
      'photo_url': photoUrl,
      'age': age,
      'phone_number': phoneNumber,
      'password': password,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdministratorRecordDocumentEquality
    implements Equality<AdministratorRecord> {
  const AdministratorRecordDocumentEquality();

  @override
  bool equals(AdministratorRecord? e1, AdministratorRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.email == e2?.email &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.age == e2?.age &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.password == e2?.password;
  }

  @override
  int hash(AdministratorRecord? e) => const ListEquality().hash(
      [e?.name, e?.email, e?.photoUrl, e?.age, e?.phoneNumber, e?.password]);

  @override
  bool isValidKey(Object? o) => o is AdministratorRecord;
}
