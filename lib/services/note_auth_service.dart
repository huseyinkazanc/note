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
        await registerUser(email: email, username: username);
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

  Future<void> registerUser({required String email, required String username}) async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      await userCollection.doc(user.uid).set({
        'username': username,
        'email': email,
      });
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      final userDoc = await userCollection.doc(user.uid).get();
      if (userDoc.exists) {
        return userDoc.data();
      } else {
        print('User document does not exist at path: users/${user.uid}');
      }
    } else {
      print('No authenticated user');
    }
    return null;
  }
}
