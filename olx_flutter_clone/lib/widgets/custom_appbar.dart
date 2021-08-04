import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx_flutter_clone/screens/location_screen.dart';
import 'package:olx_flutter_clone/services/firebase_sevices.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return FutureBuilder<DocumentSnapshot>(
      future: _services.users.doc(_services.user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Address Not Set Yet");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          if (data['address'] == null) {
            //check next data
            GeoPoint latLang = data['location'];
            _services
                .getAddress(latLang.latitude, latLang.longitude)
                .then((address) {
              return appBar(address, context);
            });
          }
          else {
            return appBar(data['address'], context);
          }
        }

        return Text("Fetching Location...");
      },
    );
  }

  Widget appBar(address, context) {
    return AppBar(
      title: InkWell(
        onTap: () {
          Navigator.pushNamed(context, LocationScreen.id);
        },
        child: Container(
          child: Row(
            children: [
              Icon(Icons.location_on),
              Expanded(
                child: Text(
                  address,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
    );
//
  }
}
