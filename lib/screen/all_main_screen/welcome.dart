import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/Authentification.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
User? users = _auth.currentUser;

class _WelcomeState extends State<Welcome> {
  String? useremail = _auth.currentUser?.email;
  String? username = _auth.currentUser?.displayName;
  String? userphotourl = _auth.currentUser?.photoURL;
  String logoutsucess = 'Logout Sucessfully';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            SizedBox(
                height: 200,
                child: Center(
                    child: Center(
                        child: Lottie.asset('assets/gif/56794-toast.json')))),
            SizedBox(
              height: 20,
            ),
            userphotourl == null
                ? Icon(
                    CupertinoIcons.person_alt_circle_fill,
                    size: 80,
                  )
                : CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('$userphotourl'),
                  ),
            SizedBox(
              height: 20,
            ),
            Text(
              "$useremail",
              style: TextStyle(
                  fontFamily: "poiret",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.brown[400]),
            ),
            Text(
              "$username",
              style: TextStyle(
                  fontFamily: "poiret",
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Colors.brown[400]),
            ),
            TextButton(
                onPressed: () async {
                  if (_auth.currentUser?.providerData[0].providerId ==
                      'google.com') {
                    print(
                        'before user data ====> $useremail,$userphotourl,$username');
                    useremail = null;
                    userphotourl = null;
                    username = null;
                    await _auth.signOut();
                    print(
                        'after user data ====> $useremail,$userphotourl,$username');
                    await Provider.of<Authentication>(context, listen: false)
                        .signoutwithgoogle()
                        .whenComplete(() {
                      users = null;
                      showlogoutsucsssnackbar(context, logoutsucess);
                      return Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Signin()),
                          (route) => false);
                    });
                  } else {
                    await _auth.signOut();
                    Timer(
                        Duration(seconds: 1),
                        () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Signin()),
                            (route) => false));
                    showlogoutsucsssnackbar(context, logoutsucess);
                  }
                },
                child: Text(
                  "logout",
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/mainhomescreen');
                },
                child: Text('homepage'))
          ],
        ),
      ),
    );
  }

  void showlogoutsucsssnackbar(BuildContext context, err) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.logout_rounded,
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
      margin: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 15,
    );

    ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    ScaffoldMessenger.of(context)..showSnackBar(snackBar);
  }
}
