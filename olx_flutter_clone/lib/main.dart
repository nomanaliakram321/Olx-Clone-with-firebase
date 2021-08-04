import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olx_flutter_clone/screens/authentications/email_auth.dart';
import 'package:olx_flutter_clone/screens/authentications/email_verification_screen.dart';
import 'package:olx_flutter_clone/screens/authentications/forget_screen.dart';
import 'package:olx_flutter_clone/screens/home_screen.dart';
import 'package:olx_flutter_clone/screens/location_screen.dart';
import 'package:olx_flutter_clone/screens/login_screen.dart';
import 'package:olx_flutter_clone/screens/authentications/phone_auth_screen.dart';
import 'package:olx_flutter_clone/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.deepPurple, fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
        LocationScreen.id: (context) => LocationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        EmailAuth.id: (context) => EmailAuth(),
        EmailVerificationScreen.id:(context) => EmailVerificationScreen(),
        ResetPasswordScreen.id:(context) => ResetPasswordScreen(),
      },
    );

    //  FutureBuilder(
    //   // Replace the 3 second delay with your initialization code:
    //   future: Future.delayed(Duration(seconds: 5)),
    //   builder: (context, AsyncSnapshot snapshot) {
    //     // Show splash screen while waiting for app resources to load:
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MaterialApp(
    //           theme: ThemeData(
    //               primaryColor: Colors.deepPurple, fontFamily: 'Lato'),
    //           debugShowCheckedModeBanner: false,
    //           home: SplashScreen());
    //     } else {
    //       // Loading is done, return the app:
    //       return MaterialApp(
    //         theme:
    //             ThemeData(primaryColor: Colors.deepPurple, fontFamily: 'Lato'),
    //         debugShowCheckedModeBanner: false,
    //         home: LoginScreen(),
    //         routes: {
    //           LoginScreen.id: (context) => LoginScreen(),
    //           PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
    //           LocationScreen.id: (context) => LocationScreen(),
    //         },
    //       );
    //     }
    //   },
    // );
  }
}
