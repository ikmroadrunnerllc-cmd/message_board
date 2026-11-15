import 'package:cloud_firestore/cloud_firestore.dart';

class UserRecord {
  final String uid;
  final String firstName;
  final String lastName;
  final String role;
  final DateTime registrationDateTime;

  UserRecord({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.registrationDateTime,
  });

  factory UserRecord.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final ts = data['registrationDateTime'] as Timestamp?;
    return UserRecord(
      uid: data['uid'] ?? doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      role: data['role'] ?? 'Student',
      registrationDateTime: ts != null ? ts.toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'registrationDateTime': FieldValue.serverTimestamp(),
    };
  }
}
