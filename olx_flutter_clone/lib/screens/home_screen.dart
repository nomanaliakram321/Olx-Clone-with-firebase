import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:olx_flutter_clone/screens/location_screen.dart';
import 'package:olx_flutter_clone/screens/login_screen.dart';
import 'package:olx_flutter_clone/widgets/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'Pakistan';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar()),
        body: Container(
            child: FlatButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            });
          },
          child: Text('signout'),
        )),
      ),
    );
  }
}
