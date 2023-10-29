import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:online_bakery_shop/admin/adminscreen.dart';
import 'package:online_bakery_shop/deliveryboy/deliveryboyscreen.dart';
import 'package:online_bakery_shop/provider/checkAUM.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/verify.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/Authentification.dart';
import 'package:online_bakery_shop/screen/all_main_screen/bottomnavbar.dart';
import 'package:online_bakery_shop/screen/all_main_screen/welcome.dart';
import 'package:provider/provider.dart';

//?  ++++++++++++++++++++++++++++++++++++++++++ import over ++++++++++++++++++++++++++++++++++++++++++//

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

//? >>>>>>>>>>>>>>>>> variable declair <<<<<<<<<<<< //

bool eye = true;
bool changebutton = false;
String _email = '';
String _password = '';
final _formkey2 = GlobalKey<FormState>();
FirebaseAuth _auth = FirebaseAuth.instance;
User? _user = _auth.currentUser;

//!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> start main class <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//

class _SignupState extends State<Signup> {
  final GoogleSignIn googlesignin = GoogleSignIn();

  // Future signinwithgoogle() async {
  //   await Authentification().signinwithgoogle();
  // }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Form(
              key: _formkey2,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Lottie.asset('assets/gif/53395-login.json', height: 350),

                  //todo <---------------------- start first textformfield --------------------------------->

                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        cursorColor: Colors.deepPurple,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Enter Email id',
                            labelText: 'Email id',
                            hintStyle: TextStyle(color: Colors.deepPurple),
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            icon: Icon(
                              CupertinoIcons.profile_circled,
                              color: Colors.deepPurple,
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter Email id";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                    ),
                  ),

                  //! <------------------------- end first textformfield textformfield --------------------->

                  //todo <---------------------- start second textformfield --------------------------------->

                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                      child: TextFormField(
                        cursorColor: Colors.deepPurple,
                        obscureText: eye,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Enter Password',
                            labelText: 'Password',
                            hintStyle: TextStyle(color: Colors.deepPurple),
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            icon: Icon(
                              CupertinoIcons.lock_fill,
                              color: Colors.deepPurple,
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    eyechange();
                                  });
                                },
                                child: Icon(
                                  (eye == true)
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.deepPurple,
                                ))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter password";
                          } else if (value.length < 6) {
                            return "Password must be 6 character long";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      ),
                    ),
                  ),

                  //! <------------------------ end second textformfield textformfield --------------------->

                  //? +++++++++++++++++++++++++++++++++ end textformfield ++++++++++++++++++++++++++++++//

                  // todo<---------------------------- start signup button -------------------------------------->
                  InkWell(
                      onTap: () {
                        if (_formkey2.currentState!.validate()) {
                          setState(() {});
                          return _signup(_email, _password);
                        } else {
                          setState(() {});
                          return null;
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 180,
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'poiret',
                              fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade300,
                              blurRadius: 5,
                            )
                          ],
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                      )),

                  //! <------------------------------ end signbutton -------------------------------------->

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Material(
                      child: InkWell(
                        highlightColor: Colors.deepPurple,
                        hoverColor: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                        splashColor: Colors.deepPurple,
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return Signin();
                          }), (route) => false);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.red,
                          ),
                          height: 30,
                          width: 280,
                          child: Center(
                            child: Text(
                              "Already have an account? Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        builddivider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        builddivider(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<Authentication>(context, listen: false)
                              .signinwithgoogle(context)
                              .whenComplete(() {
                            if (auth.currentUser != null) {
                              print(_user!.email);

                              String success = 'Successfully Login';

                              // print(
                              //     '${Provider.of<CheckADM>(context, listen: false).getadm}');
                              showerrorsnackbar(
                                context,
                                success,
                              );

                              Timer(Duration(seconds: 1), () {});

                              print(
                                  '${Provider.of<Authentication>(context, listen: false).useremail}' +
                                      '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                              if (Provider.of<Authentication>(context,
                                          listen: false)
                                      .useremail ==
                                  Provider.of<CheckADM>(context, listen: false)
                                      .getadm) {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Adminscreen();
                                }), (route) => false);
                              } else if (Provider.of<Authentication>(context,
                                          listen: false)
                                      .useremail ==
                                  "project331563@gmail.com") {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Deliveryboyscreen();
                                }), (route) => false);
                              } else {
                                setdata();

                                // FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc('${_user?.uid}')
                                //     .update({"uid": ""}).whenComplete(() {
                                //   FirebaseFirestore.instance
                                //       .collection('users')
                                //       .doc('${_user?.uid}')
                                //       .get()
                                //       .then((value) {
                                //     print("${value.data()!['uid']}" +
                                //         "check uid");
                                //     if (value.data()!['uid'] == null) {
                                //       print("i am in null uid");
                                //       FirebaseFirestore.instance
                                //           .collection('users')
                                //           .doc('${_user?.uid}')
                                //           .update({
                                //         "uid": "${_user?.uid}"
                                //       }).whenComplete(() {
                                //         FirebaseFirestore.instance
                                //             .collection('users')
                                //             .doc('${_user?.uid}')
                                //             .collection('total')
                                //             .doc('total-123')
                                //             .set({
                                //           "totalname": "${_user?.uid}"
                                //         }).whenComplete(() {
                                //           FirebaseFirestore.instance
                                //               .collection('users')
                                //               .doc('${_user?.uid}')
                                //               .collection('total')
                                //               .doc('total-123')
                                //               .get()
                                //               .then((value) {
                                //             print("${value.data()!['total']}" +
                                //                 "check uid");
                                //             if (value.data()!['total'] ==
                                //                 null) {
                                //               FirebaseFirestore.instance
                                //                   .collection('users')
                                //                   .doc('${_user?.uid}')
                                //                   .collection('total')
                                //                   .doc('total-123')
                                //                   .set({"total": 0});
                                //             }
                                //           });
                                //         });
                                //       });
                                //     }
                                //     // return value.data()!['uid'];
                                //   });
                                // });

                              }
                            } else {
                              String _errors = 'NO USER';
                              showerrorsnackbar(
                                context,
                                _errors,
                              );
                            }
                          });
                        },
                        child: Container(
                          child: sicon(),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded builddivider() {
    return Expanded(
      child: Divider(
        color: Colors.black,
        height: 1.5,
      ),
    );
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

//todo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> signup auth <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

  _signup(String _email, String _password) async {
    print("i am here");
    try {
      print("i am also here");
      await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      String success = 'Please verify email';
      //?>>>>>>>>>>> if success <<<<<<<<<<<<<<//
      showerrorsnackbar(context, success);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottombarpage()),
          (route) => false);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Verify()), (route) => false);
    }

    //?>>>>>>>>>>> else show error <<<<<<<<<<<<<<//

    on FirebaseAuthException catch (e) {
      final err = e.message;
      print(err);
      showerrorsnackbar(context, err);
    }
  }
}

Icon sicon() {
  return Icon(EvaIcons.google);
}

void showerrorsnackbar(BuildContext context, err) {
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
    margin: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 15,
  );

  ScaffoldMessenger.of(context)..hideCurrentSnackBar();
  ScaffoldMessenger.of(context)..showSnackBar(snackBar);
}
//? +++++++++++++++++++++++++++++++++++++   end all function  ++++++++++++++++++++++++++++++++++++++++//

//* * eye icon for password working function //

void eyechange() {
  if (eye == true) {
    eye = false;
  } else {
    eye = true;
  }
}
