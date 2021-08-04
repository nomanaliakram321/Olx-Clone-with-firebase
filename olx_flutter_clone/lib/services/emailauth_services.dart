import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_flutter_clone/screens/authentications/email_verification_screen.dart';
import 'package:olx_flutter_clone/screens/location_screen.dart';

class EmailAuthServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> getAdminCredential({email, password, isLog, context}) async {
    DocumentSnapshot result = await users.doc(email).get();
    if (isLog) {
      emailLogin(email, password, context);
    } else {
      if (result.exists) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('An Account of this Email is already Exists.'),
        ));
      } else {
        emailRegister(email, password, context);
      }
    }

    return result;
  }

  emailLogin(email, password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user.uid != null) {

          Navigator.pushReplacementNamed(context, LocationScreen.id);

      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No user found for that email.'),
        ));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Wrong password provided for that user.'),
        ));
        print('Wrong password provided for that user.');
      }
    }
  }

  emailRegister(email, password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user.uid != null) {
        return users.doc(userCredential.user.uid).set({
          'email': userCredential.user.email,
          'phone': null,
          'uid': userCredential.user.uid,
        }).then((value) async{
          //before going to location screen first email verification

              await userCredential.user.sendEmailVerification().then((value){
                Navigator.pushReplacementNamed(context, EmailVerificationScreen.id);
              });


        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to Add user.'),
          ));
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The password provided is too weak.'),
        ));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.'),
        ));
        print('The account already exists for that email.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error Occureds'),
      ));
      print(e);
    }
  }
}
