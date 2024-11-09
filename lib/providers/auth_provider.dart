import 'dart:math';

import 'package:e_commerce_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = StateNotifierProvider<FirebaseAuthNotifier, User?>((ref) {
  final auth = FirebaseAuth.instance;
  return FirebaseAuthNotifier(auth);
});

class FirebaseAuthNotifier extends StateNotifier<User?> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuth _auth;
  FirebaseAuthNotifier(this._auth) : super(_auth.currentUser);

  User? get currentUser => state;

  // Login:
  /*
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    state = _auth.currentUser;
  }

   */
  Future<bool> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = credential.user;
      return true;
      //return FirebaseAuthService.isAdmin(credential.user!.uid);
    } catch (err) {
      // Handle Error here
      return false;
    }
  }

  Future<bool> checkAdmin() async {
    if (state == null) return false;
    return await FirebaseAuthService.isAdmin(state!.uid);
  }

  // Logout:
  Future<void> logout() async {
   await _auth.signOut();
   state = null;
  }
}



