import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';
import 'package:olx_flutter_clone/screens/authentications/email_auth.dart';
import 'package:olx_flutter_clone/screens/authentications/google_auth.dart';
import 'package:olx_flutter_clone/screens/authentications/phone_auth_screen.dart';
import 'package:olx_flutter_clone/services/phoneauth_services.dart';

class AuthUiWidget extends StatelessWidget {
  const AuthUiWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 65),
        child: Column(
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple)),
                onPressed: () {
                  Navigator.pushNamed(context, PhoneAuthScreen.id);
                },
                child: Row(
                  children: [
                    Icon(Icons.phone_android),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text('Continue With Phone',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                )),
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen)),
                onPressed: () {},
                child: Row(
                  children: [
                    CIcon(
                      IconMoon.icon_facebook1,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Continue With Facebook',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orangeAccent)),
                onPressed: () async {
                  User user = await GoogleAuthentication.signInWithGoogle(
                      context: context);
                  if (user != null) {
                    PhoneAuthServices _services = PhoneAuthServices();
                    _services.addUser(context, user.uid);
                  }
                },
                child: Row(
                  children: [
                    CIcon(
                      IconMoon.icon_google3,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Continue With Google',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('OR', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, EmailAuth.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Login with Email',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.underline)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
