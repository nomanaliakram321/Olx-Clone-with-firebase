import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:location/location.dart';
import 'package:olx_flutter_clone/screens/home_screen.dart';
import 'package:olx_flutter_clone/screens/login_screen.dart';
import 'package:olx_flutter_clone/services/firebase_sevices.dart';

class LocationScreen extends StatefulWidget {
  static const String id = 'location-screen';
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Location location = new Location();
  String _address ;
  bool _serviceEnabled;
  bool _isloading=false;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String mandualAddress;
  FirebaseServices _services=FirebaseServices();


  Future<LocationData> setLocation() async {

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    final coordinates = new Coordinates(_locationData.latitude, _locationData.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
   var  first = addresses.first;
    setState(() {
      _address=first.addressLine;
      countryValue=first.countryName;
    });

    return _locationData;
  }

  @override
  Widget build(BuildContext context) {
    _services.users.doc(_services.user.uid).get().then((DocumentSnapshot document){
if(document.exists)
  {
    //location already updated.
    if(document['address'] !=null)
      {
        setState(() {
          _isloading=true;
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        });
      }
    else
      {
        setState(() {
          _isloading=false;
          Navigator.pushNamed(context, HomeScreen.id);
        });
      }
  }
    });
    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      progressIndicatorColor: Colors.deepPurple,
      backgroundColor: Colors.white,
      textColor: Colors.deepPurple,
      loadingText: 'Fetching Location...',
    );
    BottomSheet(context) {
      setLocation().then((location){
        if(location!=null)
          {
            progressDialog.dismiss();
            return showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              enableDrag: true,
              backgroundColor: Colors.white,
              context: context,
              builder: (BuildContext context) {
                return ListView(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    AppBar(
                      elevation: 0,
                      leading: Container(),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 10, bottom: 10, right: 8),
                          child: Container(
                            height: 20,
                            width: 40,
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
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                      centerTitle: true,
                      iconTheme: IconThemeData(color: Colors.deepPurple),
                      backgroundColor: Colors.white,
                      title: Text(
                        'Your Location',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato'),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Select Your Current City,Address',
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: ' Current Location',
                                  prefixIcon: Icon(Icons.search),
                                  hintStyle: TextStyle(color: Colors.grey.shade400),
                                  hintText: 'Location',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              ListTile(
                                onTap: (){
                                  progressDialog.show();
                                  setLocation().then((value) {
                                    if(value!=null)
                                      {
                                        _services.updateUser({
                                          'location':GeoPoint(value.longitude,value.latitude),
                                          'address':_address,

                                        }, context
                                        ).then((value) {
                                          progressDialog.dismiss();
                                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                                        });
                                      }
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  Icons.my_location,
                                  color: Colors.deepPurple,
                                  size: 35,
                                ),
                                subtitle: Text( _locationData==null ?'Fetching  Location':_address),
                                title: Text(
                                  'Use Current Location',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurple[50],
                                      borderRadius: BorderRadius.circular(9)),
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    'Choose Country',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              CSCPicker(
                                defaultCountry: DefaultCountry.Pakistan,
                                flagState:CountryFlag.DISABLE ,
                                dropdownDecoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.deepPurple[50],width: 2)),
                                onCountryChanged: (value) {
                                  setState(() {
                                    countryValue = value;
                                  });
                                },
                                onStateChanged: (value) {
                                  setState(() {
                                    stateValue = value;
                                  });
                                },
                                onCityChanged: (value) {
                                  setState(() {

                                    cityValue = value;
                                    mandualAddress='$countryValue $stateValue $cityValue';
                                  });

                                 if(value!=null)
                                   {
                                     _services.updateUser({
                                       'address':mandualAddress,
                                       'state':stateValue,
                                       'city':cityValue,
                                       'countery':countryValue
                                     }, context);
                                   }

                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        else
          {
            progressDialog.dismiss();
          }
      });

    };


    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/map2.png',
                fit: BoxFit.fill,
              ),
            ),
            Text(
              'Please Confirm Your Location',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Where Do you want to sell/Buy Products',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
          _isloading ? Column(
            children: [
              SizedBox(
                  height:30,width:30,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple) ,)),
              Text('Please Wait...',style: TextStyle(color: Colors.deepPurple),)
            ],
          ):  Column(
              children: [
                ElevatedButton.icon(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 10)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.deepPurple),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                    onPressed: () {
                      progressDialog.show();
                      setLocation().then((value) {
                        print(_locationData);
                        if (value != null) {
                          progressDialog.dismiss();
                        _services.updateUser({
                          'address':_address,
                          'location':GeoPoint(value.latitude,value.longitude),

                        }, context);
                        }
                      });
                    },
                    icon: Icon(Icons.location_on),
                    label: Text('MY Location')),
                TextButton(
                    onPressed: () {
                      progressDialog.show();
                      BottomSheet(context);
                    },
                    child: Text(
                      'Set Location Manually',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
