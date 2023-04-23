import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get loggedInUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> logIn(Student student) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: student.email, password: student.password);
      notifyListeners();
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Creates student in Firebase Auth
  Future<void> register(Student student) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: student.email, password: student.password);
    await _addStudentToStorage(student.email);
    notifyListeners();
  }

  // Creates student document in Firestore
  Future<void> _addStudentToStorage(String email) async {
    await _firebaseFirestore
        .collection('Users') // Targets the collection
        .doc(loggedInUser!.uid)
        .set({'email': email}); // Adds the document
    notifyListeners();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}
