import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  //instance of auth:
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of firestore:
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign user in
  Future<UserCredential> signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      // creating new document after user signs in as well:
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email' : email,
        'password' : password,
      }, SetOptions(merge: true));

      return userCredential;

    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign user out:

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  //create new user:
  Future<UserCredential> signUpWithEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      // creating new document after user registers:
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email' : email,
        'password' : password,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
