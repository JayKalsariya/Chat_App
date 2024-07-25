// singleton pattern

import 'package:counter/myroutes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthServices {
//Private Named constructor
  AuthServices._();

//Static Final Instance
  static final AuthServices instance = AuthServices._();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> anonymousLogin() async {
    User? user;

    try {
      UserCredential userCredential = await auth.signInAnonymously();
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
    }
    return user;
  }

  Future<User?> signUp(
      {required String email, required String password}) async {
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      Logger().e(e.toString());
    }
    return user;
  }

  Future<User?> signIn(
      {required String email, required String password}) async {
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      Logger().e(e.toString());
    }
    return user;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<PhoneAuthCredential?> phoneAuth(
      {required String phoneNumber, required BuildContext context}) async {
    PhoneAuthCredential? phoneAuthCredential;
    // Trigger the authentication flow
    await auth.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {
        phoneAuthCredential = credential;
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushNamed(context, MyRoutes.otp, arguments: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      phoneNumber: phoneNumber,
    );

    return phoneAuthCredential;
  }

  Future<void> signOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }
}
