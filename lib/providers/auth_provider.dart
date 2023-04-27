import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get loggedInUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> logIn(AppUser user) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      notifyListeners();
      return 'SUCCESS';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Creates user in Firebase Auth
  Future<void> register(AppUser user) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
    await _addUserToStorage(user.email, user.isProfessor);
    notifyListeners();
  }

  // Creates user document in Firestore
  Future<void> _addUserToStorage(String email, bool isProfessor) async {
    await _firebaseFirestore
        .collection('Users') // Targets the collection
        .doc(loggedInUser!.uid)
        .set({'email': email, 'isProfessor': isProfessor}); // Adds the document
    notifyListeners();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}
