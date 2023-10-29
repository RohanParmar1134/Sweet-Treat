import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:online_bakery_shop/alldatabase/recomended.dart';
import 'package:online_bakery_shop/provider/homedrawerprovider.dart';
import 'package:online_bakery_shop/provider/maps.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/Authentification.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/google_maps.dart';
import 'package:online_bakery_shop/screen/all_main_screen/account.dart';
import 'package:online_bakery_shop/screen/all_main_screen/allcategories.dart';
import 'package:online_bakery_shop/screen/all_main_screen/cart.dart';
import 'package:online_bakery_shop/screen/all_main_screen/getcategoriesitem.dart';
import 'package:online_bakery_shop/screen/all_main_screen/mainhomescreen.dart';
import 'package:online_bakery_shop/screen/all_main_screen/myorder.dart';
import 'package:online_bakery_shop/testingscreen/itemdetailscreen.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
User? users = _auth.currentUser;

final navigationkey = GlobalKey<CurvedNavigationBarState>();
final screen = <Widget>[Mainhomescreen(), Allcategories(), Account(), Cart()];

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    // String? useremail = _auth.currentUser?.email;
    String? useremail =
        Provider.of<Authentication>(context, listen: false).useremail;
    String? username = _auth.currentUser?.displayName;
    String? userphotourl = _auth.currentUser?.photoURL;
    String logoutsucess = 'Logout Sucessfully';
    var draweranimation = Provider.of<Homedrawerprovider>(context);

    double? xoffset = draweranimation.getxoffset;
    double? yoffset = draweranimation.getyoffset;
    double? scalefactor = draweranimation.getscalefactor;
    bool drawerstatus = draweranimation.getdrawerstatus;
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: drawerstatus == true
            ? BorderRadius.only(topLeft: Radius.circular(80))
            : BorderRadius.zero,
        color: Colors.black,
      ),
      duration: Duration(milliseconds: 250),
      transform: Matrix4.translationValues(xoffset!, yoffset!, 0)
        ..scale(scalefactor),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFC58140),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: drawerstatus == true
                  ? BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50))
                  : BorderRadius.zero,
              color: Colors.white),
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: drawerstatus == true
                      ? BorderRadius.only(topLeft: Radius.circular(50))
                      : BorderRadius.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      drawerstatus == false
                          ? IconButton(
                              onPressed: () {
                                draweranimation.opendrawer();
                              },
                              icon: Icon(CupertinoIcons.list_bullet_indent,
                                  color: Colors.white))
                          : IconButton(
                              onPressed: () {
                                draweranimation.closedrawer();
                              },
                              icon: Icon(
                                EvaIcons.arrowBack,
                                size: 30,
                              )),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'poppins'),
                              children: [
                            TextSpan(
                                text: 'Bakery',
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                                text: 'Shop',
                                style: TextStyle(color: Colors.deepOrange))
                          ])),
                      Badge(
                        badgeContent: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc('${firebaseuser?.uid}')
                              .collection('items')
                              .where('quantity', isGreaterThan: 0)
                              .snapshots(),
                          initialData: 0,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: Text('no data'));
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Text("${snapshot.data.docs.length}");
                          },
                        ),
                        position: BadgePosition.topStart(),
                        badgeStyle: BadgeStyle(badgeColor:  Colors.white),
              badgeAnimation: BadgeAnimation.scale(),
                        // badgeColor: Colors.white,
                        // animationType: BadgeAnimationType.scale,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Cart();
                              }));
                            },
                            icon:
                                Icon(CupertinoIcons.cart, color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orange[500],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60))),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Card(
                          shape: StadiumBorder(),
                          elevation: 20,
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      bool _serviceenabled;
                                      PermissionStatus _permissionStatus;
                                      // Future<LocationData> _locationdata;

                                      _serviceenabled = await Location.instance
                                          .serviceEnabled();
                                      if (!_serviceenabled) {
                                        _serviceenabled = await Location
                                            .instance
                                            .requestService();
                                        if (!_serviceenabled) {
                                          String err = "Please Enable Location";
                                          return showsuccesssnackbar(
                                              context, err);
                                        }
                                      }
                                      _permissionStatus = await Location
                                          .instance
                                          .hasPermission();
                                      if (_permissionStatus ==
                                          PermissionStatus.denied) {
                                        _permissionStatus = await Location
                                            .instance
                                            .requestPermission();
                                        if (_permissionStatus !=
                                            PermissionStatus.granted) {
                                          if (_permissionStatus ==
                                              PermissionStatus.denied) {
                                            _permissionStatus = await Location
                                                .instance
                                                .requestPermission();
                                          }
                                          _permissionStatus = await Location
                                              .instance
                                              .requestPermission();
                                          String err =
                                              "Please Give Permission For Location";
                                          return showsuccesssnackbar(
                                              context, err);
                                        }
                                      }
                                      if (_serviceenabled &&
                                          _permissionStatus ==
                                              PermissionStatus.granted) {
                                        (Provider.of<GenerateMaps>(context,
                                                    listen: false)
                                                .getcurrentlocation())
                                            .whenComplete(() {
                                          Provider.of<Changeaddress>(context,
                                                  listen: false)
                                              .cleanadd();
                                          return Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Googlemaps();
                                          }));
                                        });
                                      }
                                    },
                                    icon: Icon(CupertinoIcons.location)),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return Myorder();
                                        },
                                      ));
                                    },
                                    icon:
                                        Icon(Icons.my_library_books_outlined)),
                                CupertinoButton(
                                    child: Icon(
                                      CupertinoIcons.search,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      showSearch(
                                        context: context,
                                        delegate: CustomSearchDelegate(),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Recomended(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//! --------------------------------- functions ------------------------------------------------------------->

  void showsuccesssnackbar(BuildContext context, err) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            size: 32,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Text(
            '$err',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ))
        ],
      ),
      backgroundColor: Colors.blue[100],
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 15,
    );

    ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    ScaffoldMessenger.of(context)..showSnackBar(snackBar);
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> listitem = ['bread', 'bun', 'cake', 'cookie', 'pizzabase'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchquery = [];
    for (var fruit in listitem) {
      if (fruit.contains(query.toLowerCase())) {
        matchquery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (BuildContext context, int index) {
        var result = matchquery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchquery = [];
    for (var fruit in listitem) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (BuildContext context, int index) {
        var result = matchquery[index];
        return ListTile(
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Getcategoriesitems(itemname: result);
              },
            ));
          },
          title: Text(result),
        );
      },
    );
  }
}
