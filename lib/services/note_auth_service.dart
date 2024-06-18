import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection('users');
  final firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signUp({required String email, required String username, required String password}) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await _registerUser(email: email, username: username, password: password);
        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      print('Failed to sign up: $e');
    }
    return null;
  }

  Future<UserCredential?> signIn({required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in: $e');
    }
    return null;
  }

  Future<void> _registerUser({required String email, required String username, required String password}) async {
    await userCollection.doc().set({
      'username': username,
      'email': email,
      'password': password,
    });
  }
}
