import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  //instance for auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance for firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //sign user in
  Future<UserCredential> signInWithaEmailandPassword(
      String email, String password) async {
    try {
      //sign in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // add a new doc for user in users collection if it doesn't exists
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      },
      SetOptions(merge: true));

      return userCredential;
    }
    //catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //create a user
  Future<UserCredential> signUpWithEmailandPasswor(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //after creating user, create a new user in the users collection
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception((e.code));
    }
  }

//sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
