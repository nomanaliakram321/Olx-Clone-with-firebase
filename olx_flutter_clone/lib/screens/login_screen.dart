import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_flutter_clone/screens/location_screen.dart';
import 'package:olx_flutter_clone/widgets/auth_ui_widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login-screen';
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 150,
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Buy Or Sell',
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: AuthUiWidget(),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                  'Our Terms and Conditions template will get you started with creating your own custom Terms and Conditions agreement.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Colors.black26)),
            ),
          ],
        ),
      ),
    );
  }
}
