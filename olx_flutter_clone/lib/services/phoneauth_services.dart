import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_flutter_clone/screens/authentications/otp_screen.dart';
import 'package:olx_flutter_clone/screens/location_screen.dart';

class PhoneAuthServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User user = FirebaseAuth.instance.currentUser;
  Future<void> addUser(context, uid) async {
    // Call the user's CollectionReference to add a new user
    final QuerySnapshot result = await users.where('uid', isEqualTo: uid).get();
    List<DocumentSnapshot> documentSnapshot = result.docs;
    if (documentSnapshot.length > 0) {
      Navigator.pushReplacementNamed(context, LocationScreen.id);
    } else {
      return users.doc(user.uid).set({
        'uid': user.uid, // John Doe
        'phone': user.phoneNumber, // Stokes and Sons
        'email': user.email // 42
      }).then((value) {
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      }).catchError((error) => print("Failed to add user: $error"));
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> verifyPhoneNumber(BuildContext context, number) {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
      print('the error is ${e.code}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int resendToken) async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPScreen(
                    number: number,
                    verid: verificationId,
                  )));
    };
    try {
      auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
          print(verificationId);
        },
      );
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
}
