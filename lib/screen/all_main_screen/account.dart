import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:online_bakery_shop/provider/maps.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/phoneno.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/google_maps.dart';
import 'package:online_bakery_shop/screen/all_main_screen/cart.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

final _formkey1 = GlobalKey<FormState>();
TextEditingController namectrl = TextEditingController();
String? manualname;

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _authe = FirebaseAuth.instance;
    User? users = _authe.currentUser;
    String? _username = null;
    // _auth.currentUser?.displayName;
    String? _useremail = _authe.currentUser?.email;
    String? _userphotourl = _authe.currentUser?.photoURL;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _userphotourl != null
                ? Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('$_userphotourl'),
                    ),
                  )
                : Center(
                    child: Icon(
                      CupertinoIcons.person,
                      size: 50,
                      // color: Colors.black,
                    ),
                  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _username != null
                    ? Text('$_username',
                        style: TextStyle(
                            // color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'poppins'))
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc('${firebaseuser?.uid}')
                            .collection('total')
                            .doc('total-123')
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) => buildsheet());
                                  },
                                  child: Text("Add Name",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'poppins'))),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return snapshot.data['name'] == ""
                              ? TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) => buildsheet());
                                  },
                                  child: Text("Add Name",
                                      style: TextStyle(
                                          // color: Colors.,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'poppins')))
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Name:  " + snapshot.data['name'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            // fontWeight: FontWeight.w600,
                                            fontFamily: 'poppins')),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.edit))
                                  ],
                                );
                        },
                      ),
                Text("Email:  " + '$_useremail',
                    style: TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.w600,
                        fontFamily: 'poppins')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc('${firebaseuser?.uid}')
                        .collection('total')
                        .doc('total-123')
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text('no data'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return snapshot.data['phoneno'] == 0 ||
                              snapshot.data['phoneno'].toString().length < 10
                          ? CupertinoButton(
                              child: Text("Add Phone Number"),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Phoneno();
                                }));
                              })
                          : Column(
                              children: [
                                Text(
                                    "Phone number: " +
                                        "${snapshot.data['phoneno']}",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'poppins')),
                                CupertinoButton(
                                    color: Colors.blue,
                                    child: Text("Change Phone Number"),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Phoneno();
                                      }));
                                    })
                              ],
                            );
                    },
                  ),
                ),
              ],
            ),
            fetchaddress(),
          ],
        ),
      ),
    );
  }

  fetchaddress() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc('${firebaseuser?.uid}')
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
                width: MediaQuery.of(context).size.width,
                height: 60,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.map_pin_ellipse,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add Address",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'cascadia'),
                      )
                    ],
                  ),
                ),
              ));
        }
        return Column(
          children: [
            Card(
              color: Color(0xFFC58140),
              // elevation: ,
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
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.all(10),
              // color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                splashColor: Colors.lightBlueAccent[10],
                onTap: () async {
                  bool _serviceenabled;
                  PermissionStatus _permissionStatus;
                  // Future<LocationData> _locationdata;

                  _serviceenabled = await Location.instance.serviceEnabled();
                  if (!_serviceenabled) {
                    _serviceenabled = await Location.instance.requestService();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.map_pin_ellipse,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Change Address",
                      style: TextStyle(fontSize: 16, fontFamily: 'cascadia'),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget buildsheet() {
    return Form(
      key: _formkey1,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: namectrl,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: "Enter Full Name",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Full Name";
                  }
                },
                onChanged: (value) {
                  setState(() {
                    manualname = value;
                  });
                },
              ),
            ),
            CupertinoButton(
                color: Colors.orange,
                child: Text(
                  "Save",
                ),
                onPressed: () async {
                  if (_formkey1.currentState!.validate()) {
                    setState(() {});
                    savemanualnametofirebase();
                    // return _signin(_email, _password);
                  } else {
                    setState(() {});
                    return null;
                  }
                })
          ],
        ),
      ),
    );
  }

  savemanualnametofirebase() async {
    Navigator.pop(context);
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${firebaseuser?.uid}')
        .collection('total')
        .doc('total-123')
        .update({"name": manualname});
  }
}
