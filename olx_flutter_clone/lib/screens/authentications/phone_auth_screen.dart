import 'package:bd_progress_bar/loaders/color_loader_2.dart';
import 'package:bd_progress_bar/loaders/color_loader_3.dart';
import 'package:bd_progress_bar/loaders/color_loader_4.dart';
import 'package:bd_progress_bar/loaders/color_loader_6.dart';
import 'package:bd_progress_bar/loaders/dot_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:olx_flutter_clone/screens/authentications/otp_screen.dart';
import 'package:olx_flutter_clone/services/phoneauth_services.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const String id = 'phoneauth-screen';

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  PhoneAuthServices _services = PhoneAuthServices();
  var _countryController = TextEditingController(text: '+92');
  var _phoneNumberController = TextEditingController();
  bool _validate = false;

  // ColorLoader2(
  // color1: Colors.deepPurple,
  // color2: Colors.green,
  // color3: Colors.orangeAccent,
  // border1Revers: true,
  //
  // ),

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
          'Login with Phone',
          style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato'),
        ),
      ),
      body: ListView(children: [
        Center(
          child: SizedBox(
            width: 300,
            child: Image.asset(
              'assets/images/phone_login.png',
            ),
          ),
        ),
        Text(
          'Enter Phone Number',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        Text(
          'We will send code to your phone Number',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _countryController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Countery',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(),
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 5,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      if (value.length == 10) {
                        setState(() {
                          _validate = true;
                        });
                      } else {
                        setState(() {
                          _validate = false;
                        });
                      }
                    },
                    maxLength: 10,
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: ' Phone Number',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      hintText: 'Enter Phone Number',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      border: OutlineInputBorder(),
                    ),
                  )),
            ],
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
                  String number =
                      '${_countryController.text}${_phoneNumberController.text}';
                  progressDialog.show();
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen()));

                  _services.verifyPhoneNumber(context, number).then((value) {
                    progressDialog.dismiss();
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ),
        )
      ]),
    );
  }
}
