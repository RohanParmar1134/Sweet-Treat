import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_bakery_shop/admin/adminscreen.dart';
import 'package:online_bakery_shop/deliveryboy/deliveryboyscreen.dart';
import 'package:online_bakery_shop/provider/checkAUM.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/Authentification.dart';
import 'package:online_bakery_shop/screen/all_main_screen/bottomnavbar.dart';
import 'package:online_bakery_shop/screen/all_main_screen/mainhomescreen.dart';

import 'package:provider/provider.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

final _auth = FirebaseAuth.instance;
Timer? timer;
final _user = _auth.currentUser;
final emailid = _user!.email;

class _VerifyState extends State<Verify> {
  @override
  void initState() {
    final user = _auth.currentUser;

    user!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkemailverify();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/gif/forverify/72126-email-verification.json'),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: SizedBox(
                child: Column(
                  children: [
                    Text(
                      '$emailid',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Please check inbox and Verify your email.',
                      style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cascadia'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkemailverify() async {
    final user = _auth.currentUser;

    await user!.reload();

    if (user.emailVerified) {
      timer?.cancel();
      print(_user!.email);

      // String success = 'Successfully Login';

      print('${Provider.of<CheckADM>(context, listen: false).getadm}');
      // showerrorsnackbar(context, success, Icons.done_all_rounded, Colors.blue);

      Timer(Duration(seconds: 1), () {});

      print('${Provider.of<Authentication>(context, listen: false).useremail}' +
          '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
      if (Provider.of<Authentication>(context, listen: false).useremail ==
          Provider.of<CheckADM>(context, listen: false).getadm) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return Adminscreen();
        }), (route) => false);
      } else if (Provider.of<Authentication>(context, listen: false)
              .useremail ==
          "project331563@gmail.com") {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return Deliveryboyscreen();
        }), (route) => false);
      } else {
        setdata();
      }
    }
  }

  setdata() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .set({"uid": "${_user?.uid}"}).whenComplete(() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${_user?.uid}')
          .update({
        "name": "name",
        "email": "email",
        "phoneno": "phoneno"
      }).whenComplete(() async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${_user?.uid}')
            .collection('total')
            .doc('total-123')
            .get()
            .then((value) async {
          if (!value.exists) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc('${_user?.uid}')
                .collection('total')
                .doc('total-123')
                .set({"totalname": "${_user?.uid}"});
          }
        }).whenComplete(() async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc('${_user?.uid}')
              .collection('total')
              .doc('total-123')
              .get()
              .then((value) async {
            print(value.metadata);

            print(value.data()!['total']);

            if (value.data()!['address'] == null) {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('${_user?.uid}')
                  .collection('total')
                  .doc('total-123')
                  .update({"address": "", "phoneno": 0, "name": ""});
              if (value.data()!['total'] == null) {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('${_user?.uid}')
                    .collection('total')
                    .doc('total-123')
                    .update({"total": 0});
              }
              if (value.data()!['orderid'] == null) {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('${_user?.uid}')
                    .collection('total')
                    .doc('total-123')
                    .update({"orderid": 0});
              }
            }
          }).whenComplete(() async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc('${_user?.uid}')
                .collection('myorder')
                .doc('checkorderdoc')
                .get()
                .then((value) async {
              if (!value.exists) {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('${_user?.uid}')
                    .collection('myorder')
                    .doc('checkorderdoc')
                    .set({"purpose": "forcheckpurpose"});
              }
            });
          });
        });
      }).whenComplete(() {
        Future.delayed(Duration(seconds: 5), () {
          print("success");
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return Bottombarpage();
          }), (route) => false);
        });
      });
    });
  }

  void showvarifyemailsnackbar(BuildContext context, err) {
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
      backgroundColor: Colors.red,
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
