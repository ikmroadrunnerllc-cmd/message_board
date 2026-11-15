import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

class BoardService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _messages =>
      _db.collection('messages');

  Future<void> postMessage({
    required String authorUid,
    required String authorName,
    required String text,
  }) async {
    await _messages.add({
      'authorUid': authorUid,
      'authorName': authorName,
      'text': text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Message>> messageBoard() {
    return _messages
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
  }

  Future<void> editMessage({
    required String messageId,
    required String newText,
  }) async {
    await _messages.doc(messageId).update({
      'text': newText.trim(),
      'editedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteMessage({required String messageId}) async {
    await _messages.doc(messageId).delete();
  }
}
