import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  User? get loggedInUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> logIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      String errorText = '';
      switch (e.code) {
        case 'invalid-email':
          errorText = 'Invalid email address.';
          break;
        case 'user-disabled':
          errorText = 'User account has been disabled.';
          break;
        case 'user-not-found':
          errorText = 'User account not found.';
          break;
        case 'wrong-password':
          errorText = 'Incorrect password.';
          break;
        default:
          errorText = 'An unknown error occurred.';
          break;
      }
      return errorText;
    }
  }

  // Creates student in Firebase Auth
  Future<void> register(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await addStudentToStorage(email);
  }

  // Creates student document in Firestore
  Future<void> addStudentToStorage(String email) async {
    await _firebaseFirestore
        .collection('Users') // Targets the collection
        .doc(loggedInUser!.uid)
        .set({'email': email}); // Adds the document
  }

  Future<void> signOut() async => await _firebaseAuth.signOut();
}
