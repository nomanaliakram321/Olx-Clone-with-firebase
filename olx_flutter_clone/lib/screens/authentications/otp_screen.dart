import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx_flutter_clone/screens/authentications/phone_auth_screen.dart';
import 'package:olx_flutter_clone/screens/location_screen.dart';
import 'package:olx_flutter_clone/services/phoneauth_services.dart';

class OTPScreen extends StatefulWidget {
  final String number, verid;

  const OTPScreen({Key key, this.number, this.verid}) : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _isloading = false;
  String error = '';
  var _text1 = TextEditingController();
  var _text2 = TextEditingController();
  var _text3 = TextEditingController();
  var _text4 = TextEditingController();
  var _text5 = TextEditingController();
  var _text6 = TextEditingController();
  PhoneAuthServices _services = PhoneAuthServices();
  Future<void> phoneCredential(BuildContext context, String otp) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verid, smsCode: otp);
      User user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        _services.addUser(context, user.uid);
      } else {
        print('login Failed');
        if (mounted) {
          setState(() {
            error = 'Login Failed';
          });
        }
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        setState(() {
          error = 'Invalid OTP';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.deepPurple),
        backgroundColor: Colors.white,
        title: Text(
          'OTP Screen',
          style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Please Enter Code',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'We Sent Code to: ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      children: [
                        TextSpan(
                            text: widget.number,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                      ]),
                ),
                CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.deepPurple,
                    child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhoneAuthScreen()));
                        }))
              ],
            ),
            Text(
              'Please Enter 6 Digit Code',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _text1,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _text2,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _text3,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _text4,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _text5,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _text6,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          if (_text1.text.length == 1) {
                            if (_text2.text.length == 1) {
                              if (_text3.text.length == 1) {
                                if (_text4.text.length == 1) {
                                  if (_text5.text.length == 1) {
                                    String otp =
                                        '${_text1.text}${_text2.text}${_text3.text}${_text4.text}${_text5.text}${_text6.text}';
                                    setState(() {
                                      _isloading = true;
                                    });
                                    phoneCredential(context, otp);
                                  }
                                }
                              }
                            }
                          }
                        } else {
                          setState(() {
                            _isloading = false;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            if (_isloading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.purple.shade50,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
