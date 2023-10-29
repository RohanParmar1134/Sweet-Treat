import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:online_bakery_shop/provider/maps.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/Authentification.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/google_maps.dart';
import 'package:online_bakery_shop/screen/all_main_screen/account.dart';
import 'package:online_bakery_shop/screen/all_main_screen/allcategories.dart';
import 'package:online_bakery_shop/screen/all_main_screen/contactus.dart';
import 'package:online_bakery_shop/screen/all_main_screen/myorder.dart';
import 'package:online_bakery_shop/screen/all_main_screen/setting.dart';
import 'package:provider/provider.dart';

class Drawerscreen extends StatefulWidget {
  const Drawerscreen({Key? key}) : super(key: key);

  @override
  State<Drawerscreen> createState() => _DrawerscreenState();
}

FirebaseAuth _auth0 = FirebaseAuth.instance;
User? users0 = _auth0.currentUser;
String? _username0 = _auth0.currentUser?.displayName;
String? _useremail0 = _auth0.currentUser?.email;
String? _userphotourl0 = _auth0.currentUser?.photoURL;

class _DrawerscreenState extends State<Drawerscreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? users = _auth.currentUser;
    String? _username = _auth.currentUser?.displayName;
    String? _useremail = _auth.currentUser?.email;
    String? _userphotourl = _auth.currentUser?.photoURL;
    // String? address =
    //     Provider.of<GenerateMaps>(context, listen: false).getputaddress;
    // print(address);

    return Material(
      color: Color(0xFFC58140),
      // color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 80, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      _userphotourl != null
                          ? CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('$_userphotourl'),
                            )
                          : Icon(
                              CupertinoIcons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _username != null
                              ? Text('$_username',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'poppins'))
                              : Text("NO Name",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'poppins')),
                          Text('$_useremail',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'poppins')),
                        ],
                      )
                    ],
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    menuoption(CupertinoIcons.decrease_indent, "All Categories",
                        context, Allcategories()),
                    menuoption(Icons.my_library_books_outlined, "My Orders",
                        context, Myorder()),
                    menuoption(CupertinoIcons.profile_circled, "Account",
                        context, Account()),
                    menuoption(CupertinoIcons.conversation_bubble, "Contact us",
                        context, Contactus()),
                    Container(
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
                        onTap: logoutfun,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Log out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'poppins'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                // Positioned(child: Text("DEVELOPED BY ROHAN PARMAR"))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Text(
              "DEVELOPED BY ROHAN PARMAR",
              style: TextStyle(
                  fontFamily: 'cascadia',
                  fontWeight: FontWeight.w100,
                  color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }

  logoutfun() async {
    if (_auth0.currentUser?.providerData[0].providerId == 'google.com') {
      print('before user data ====> $_useremail0,$_userphotourl0,$_username0');

      _useremail0 = null;
      _userphotourl0 = null;
      _username0 = null;
      await _auth0.signOut();
      print('after user data ====> $_useremail0,$_userphotourl0,$_username0');
      await Provider.of<Authentication>(context, listen: false)
          .signoutwithgoogle()
          .whenComplete(() {
        users0 = null;

        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Signin()),
            (route) => false);
      });
    } else {
      await _auth0.signOut();

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Signin()), (route) => false);
    }
  }
}

menuoption(IconData iconname, String stringname, context, funname) {
  return Container(
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
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return funname;
        }));
      },
      child: Row(
        children: [
          Icon(
            iconname,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            stringname,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'poppins'),
          )
        ],
      ),
    ),
  );
}
