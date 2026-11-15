import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_record.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import 'board_screen.dart';

class ProfileGate extends StatefulWidget {
  final User user;

  const ProfileGate({super.key, required this.user});

  @override
  State<ProfileGate> createState() => _ProfileGateState();
}

class _ProfileGateState extends State<ProfileGate> {
  final UserService _userService = UserService();
  final AuthService _auth = AuthService();
  late Future<UserRecord?> _profileFuture;

  final _first = TextEditingController();
  final _last = TextEditingController();
  String _role = 'Student';
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _profileFuture = _userService.getUserRecord(widget.user.uid);
  }

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_first.text.trim().isEmpty || _last.text.trim().isEmpty) return;
    setState(() => _saving = true);
    try {
      await _userService.saveUserRecord(
        widget.user,
        firstName: _first.text,
        lastName: _last.text,
        role: _role,
      );
      setState(() {
        _profileFuture = _userService.getUserRecord(widget.user.uid);
      });
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserRecord?>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final record = snapshot.data;
        if (record != null) {
          return BoardScreen(user: widget.user, record: record);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Complete Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => _auth.signOut(),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Your account was created, but your profile needs to be saved.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _first,
                  decoration: const InputDecoration(labelText: 'First Name', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _last,
                  decoration: const InputDecoration(labelText: 'Last Name', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _role,
                  decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'Student', child: Text('Student')),
                    DropdownMenuItem(value: 'Faculty', child: Text('Faculty')),
                    DropdownMenuItem(value: 'Staff', child: Text('Staff')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _role = v);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saving ? null : _saveProfile,
                  child: _saving
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Save Profile and Enter'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
