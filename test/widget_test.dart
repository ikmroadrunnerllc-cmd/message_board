import 'package:flutter_test/flutter_test.dart';
import 'package:message_board/models/user_record.dart';
import 'package:message_board/models/message.dart';

void main() {
  test('UserRecord creates and formats correctly', () {
    final now = DateTime(2026, 11, 15, 10, 0);
    final user = UserRecord(
      uid: 'user_123',
      firstName: 'Ada',
      lastName: 'Lovelace',
      role: 'Student',
      registrationDateTime: now,
    );

    expect(user.uid, 'user_123');
    expect(user.firstName, 'Ada');
    expect(user.lastName, 'Lovelace');
    expect(user.role, 'Student');
    expect(user.registrationDateTime, now);
  });

  test('Message model creates correctly', () {
    final now = DateTime(2026, 11, 15, 12, 0);
    final msg = Message(
      id: 'msg_001',
      text: 'Hello world',
      authorUid: 'user_123',
      authorName: 'Ada Lovelace',
      createdAt: now,
    );

    expect(msg.id, 'msg_001');
    expect(msg.text, 'Hello world');
    expect(msg.authorUid, 'user_123');
    expect(msg.authorName, 'Ada Lovelace');
    expect(msg.createdAt, now);
    expect(msg.editedAt, isNull);
  });
}
