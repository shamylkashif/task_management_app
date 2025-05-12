import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? user;

  AuthProvider() {
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? firebaseUser) {
    user = firebaseUser;
    notifyListeners();
  }

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }


  Future<bool> registerWithEmail(String email, String password) async {
    try {
      // Firebase or authentication logic here
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return true; // Return true if sign-up is successful
    } catch (e) {
      return false; // Return false if an error occurs
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
