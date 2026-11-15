import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_record.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(
    User user, {
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    await _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'role': role,
      'registrationDateTime': FieldValue.serverTimestamp(),
    });
  }

  Future<UserRecord?> getUserRecord(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserRecord.fromFirestore(doc);
  }
}
