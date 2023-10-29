import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:online_bakery_shop/admin/adminscreen.dart';
import 'package:online_bakery_shop/deliveryboy/deliveryboyscreen.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/verify.dart';
import 'package:online_bakery_shop/screen/all_main_screen/bottomnavbar.dart';
import 'package:online_bakery_shop/screen/all_main_screen/mainhomescreen.dart';
import 'package:overlay_support/overlay_support.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  var admindoclength;
  var deliveryboydoclength;
  User? user = FirebaseAuth.instance.currentUser;
  final GoogleSignIn googlesignin = GoogleSignIn();
  bool hasconnection = false;
  bool hasinternet = false;
  Timer? time;
  @override
  void initState() {
    var d = Duration(seconds: 6);
    Future.delayed(d, () async {
      hasconnection = await InternetConnectionChecker().hasConnection;
      InternetConnectionChecker().onStatusChange.listen((status) {
        hasinternet = status == InternetConnectionStatus.connected;
        // setState(() => this.hasinternet = hasinternet);
      });
      final text = hasconnection ? 'internet' : 'no internet';

      showerroraftersplashsnackbar(context, text);
      // if (text == 'internet') {
      try {
        await user?.reload();
      } on FirebaseAuthException catch (e) {
        print('$e');
      }
      final n = null;
      if (user != n && user!.emailVerified) {
        print(user!.email);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          if (user!.email == "rohanparmar1162@gmail.com") {
            return Adminscreen();
          } else if (user!.email == "project331563@gmail.com") {
            return Deliveryboyscreen();
          } else {
            // Provider.of<Getpermission>(context, listen: false).forpermission();
            return Bottombarpage();
          }
        }), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Signin()),
            (route) => false);
      }
      timer?.cancel();
      // } else {
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (context) => Checkconnection()),
      //       (route) => false);
      // }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: Material(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Lottie.asset("assets/gif/22484-bakery-shop-store-building.json",
                fit: BoxFit.contain),
            SizedBox(height: 50),
            Text(
              "BAKERY SHOP",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontFamily: 'badscript',
                fontSize: 50,
                color: Colors.orange[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showerroraftersplashsnackbar(BuildContext context, result) {
    // final hasconnect = result != ConnectivityResult.none;
    // final message = hasconnect
    //     ? 'you have again ${result.toString()}'
    //     : 'you have no internet connetion';
    String message = result;
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
            '$message',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ))
        ],
      ),
      backgroundColor: hasconnection ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.symmetric(vertical: 18, horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 15,
    );

    ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    ScaffoldMessenger.of(context)..showSnackBar(snackBar);
  }
}

class Check {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
              'assets/gif/forverify/9010-no-connection-animation.json'),
          SizedBox(
            height: 50,
          ),
          Text(
            'please check internet connection',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
