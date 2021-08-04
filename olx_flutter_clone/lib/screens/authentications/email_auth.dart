import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:olx_flutter_clone/screens/authentications/forget_screen.dart';
import 'package:olx_flutter_clone/services/emailauth_services.dart';

class EmailAuth extends StatefulWidget {
  static const String id = 'email-auth';
  const EmailAuth({Key key}) : super(key: key);

  @override
  _EmailAuthState createState() => _EmailAuthState();
}

class _EmailAuthState extends State<EmailAuth> {
  bool _validate = false;
  var _email = TextEditingController();
  bool _login = false;
  bool _isloading = false;
  var _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  EmailAuthServices _services = EmailAuthServices();
  _validateEmail() {
    if (_formkey.currentState.validate()) {
      setState(() {
        _validate = false;
        _isloading = true;
      });
      _services
          .getAdminCredential(
              email: _email.text,
              password: _password.text,
              context: context,
              isLog: _login)
          .then((value) {
        setState(() {
          _validate = false;
          _isloading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      progressIndicatorColor: Colors.deepPurple,
      backgroundColor: Colors.white,
      textColor: Colors.deepPurple,
    );
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
          '${_login ? 'Login' : 'Register'} with Email',
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
                  'assets/images/signin.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
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
                  decoration: InputDecoration(
                    labelText: ' Email',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    hintText: 'Email',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _password,
                  onChanged: (value) {
                    if (_email.text.isNotEmpty) {
                      if (value.length > 4) {
                        setState(() {
                          _validate = true;
                        });
                      } else {
                        setState(() {
                          _validate = false;
                        });
                      }
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: ' Passowrd',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    hintText: 'Password',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ResetPasswordScreen.id);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: AbsorbPointer(
                  absorbing: _validate ? false : true,
                  child: FlatButton(
                      color: _validate ? Colors.deepPurple : Colors.grey,
                      onPressed: () {
                        _validateEmail().then((value) {});
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: _isloading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              '${_login ? 'Login' : 'Register'}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _login = !_login;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        '${_login ? 'If you Don\'t have Account?' : 'Do You have Account?'} ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    Text(' ${_login ? 'Register' : 'Login'}',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
