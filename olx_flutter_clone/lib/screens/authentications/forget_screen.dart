import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_flutter_clone/screens/authentications/email_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset-password';
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var _email = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.deepPurple[100],
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset.zero)
                ]),
            child: FlatButton(
              padding: EdgeInsets.all(3),
              color: Colors.deepPurple,
              height: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.deepPurple),
        backgroundColor: Colors.white,
        title: Text(
          ' Reset Password',
          style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato'),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/forget.png',
                ),
              ),
              Text(
                'Forgot Passoword?',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Enter Your Email to Recover Your Password',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                    validator: (value) {
                      final bool isValid = EmailValidator.validate(_email.text);
                      if (value == null || value.isEmpty) {
                        return ' Enter Email ';
                      }
                      if (value.isNotEmpty && isValid == false) {
                        return ' Enter Valid Email ';
                      }
                      return null;
                    },
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  decoration: InputDecoration(
                    labelText: ' Registered Email',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    hintText: 'Enter Your Email',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                  color: Colors.deepPurple,
                  onPressed: () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _email.text)
                        .then((value) {
                      Navigator.pushReplacementNamed(context, EmailAuth.id);
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
