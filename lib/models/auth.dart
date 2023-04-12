import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
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

  Future<void> register(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
  // For creating users in firestore

  /* void createUserInFirestore(user) {
  // Get a reference to the Firestore collection
  const usersCollection = .firestore().collection('users');

  // Create a new document with the user's UID as the document ID
  usersCollection.doc(user.uid).set({
    email: user.email,
    displayName: user.displayName,
    photoURL: user.photoURL,
    // Add any other user data you want to store in Firestore
  })
  .then(() => {
    print('User created in Firestore:', user.uid);
  })
  .catch((e) => {
    print('Error creating user in Firestore:', e);
  });
} */

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
