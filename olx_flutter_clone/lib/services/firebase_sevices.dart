import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:olx_flutter_clone/screens/home_screen.dart';

class FirebaseServices{
  CollectionReference users=FirebaseFirestore.instance.collection('users');
  User user=FirebaseAuth.instance.currentUser;
  Future<void> updateUser(Map<String,dynamic>data,context) {
    return users
        .doc(user.uid)
        .update(data)
        .then((value) => Navigator.pushReplacementNamed(context, HomeScreen.id))
        .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to Update Data'),
        ),
      );
    });
  }
 Future<String> getAddress(lat,long)async{
   final coordinates = new Coordinates(lat, long);
   var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
   var  first = addresses.first;
   return first.addressLine;
 }
}