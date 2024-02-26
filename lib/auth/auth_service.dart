import 'package:firebase_auth/firebase_auth.dart';

import '../db/db_helper.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  static Future<void> loginUser(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> logout() async {
    return _auth.signOut();
  }
}