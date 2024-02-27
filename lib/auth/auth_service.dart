import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/db/db_helper.dart';
import 'package:ecom_user/models/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  static Future<void> loginUser(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> registerUser(String email, String password, String name) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final appUser = AppUserModel(uid: credential.user!.uid, email: credential.user!.email!, userCreationTime: Timestamp.fromDate(credential.user!.metadata.creationTime!), displayName: name);
    return DbHelper().addNewUser(appUser);
  }

  static Future<void> logout() async {
    return _auth.signOut();
  }
}