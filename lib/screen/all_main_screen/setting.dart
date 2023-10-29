import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:online_bakery_shop/provider/maps.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/google_maps.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arr = [
      {
        "name": "Address",
        "profile": "Profile",
      },
      {"name": "address2", "profile": "profile2"},
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text("Setting"),
          centerTitle: true,
          backgroundColor: Colors.orange,
          titleTextStyle: TextStyle(
              fontFamily: 'poppins', fontSize: 20, fontWeight: FontWeight.bold),
        ),
        body: Column(
          children: [
            list(context),
          ],
        ));
  }

  list(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: 70,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [fetchaddress()],
            ),
          ),
        ),
      ),
    );
  }

  fetchaddress() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc('${auth.currentUser?.uid}')
          .collection('total')
          .doc('total-123')
          .snapshots(),
      initialData: "set address",
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data['address'] == "" ||
            !snapshot.hasData ||
            snapshot.data['address'] == "null") {
          return TextButton(
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.all(10),
                // color: Colors.white,
                width: 180,
                height: 40,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  splashColor: Colors.lightBlueAccent[10],
                  onTap: () async {
                    bool _serviceenabled;
                    PermissionStatus _permissionStatus;
                    // Future<LocationData> _locationdata;

                    _serviceenabled = await Location.instance.serviceEnabled();
                    if (!_serviceenabled) {
                      _serviceenabled =
                          await Location.instance.requestService();
                      if (!_serviceenabled) {
                        String err = "Please Enable Location";
                        return showsuccesssnackbar(context, err);
                      }
                    }
                    _permissionStatus = await Location.instance.hasPermission();
                    if (_permissionStatus == PermissionStatus.denied) {
                      _permissionStatus =
                          await Location.instance.requestPermission();
                      if (_permissionStatus != PermissionStatus.granted) {
                        if (_permissionStatus == PermissionStatus.denied) {
                          _permissionStatus =
                              await Location.instance.requestPermission();
                        }
                        _permissionStatus =
                            await Location.instance.requestPermission();
                        String err = "Please Give Permission For Location";
                        return showsuccesssnackbar(context, err);
                      }
                    }
                    if (_serviceenabled &&
                        _permissionStatus == PermissionStatus.granted) {
                      (Provider.of<GenerateMaps>(context, listen: false)
                              .getcurrentlocation())
                          .whenComplete(() {
                        Provider.of<Changeaddress>(context, listen: false)
                            .cleanadd();
                        return Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Googlemaps();
                        }));
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.map_pin_ellipse,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add Address",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'cascadia'),
                      )
                    ],
                  ),
                ),
              ));
        }
        return Card(
          color: Color(0xFFC58140),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              snapshot.data['address'],
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[350]),
            ),
          ),
        );
      },
    );
  }
}
