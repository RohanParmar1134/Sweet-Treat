import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_bakery_shop/admin/adminscreen.dart';
import 'package:online_bakery_shop/deliveryboy/deliveryboyscreen.dart';
import 'package:online_bakery_shop/provider/checkAUM.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/passwordreset.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signup.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/verify.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/Authentification.dart';
import 'package:online_bakery_shop/screen/all_main_screen/bottomnavbar.dart';
import 'package:online_bakery_shop/screen/all_main_screen/mainhomescreen.dart';
import 'package:provider/provider.dart';

//?  ++++++++++++++++++++++++++++++++++++++++++ import over ++++++++++++++++++++++++++++++++++++++++++//

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

//? >>>>>>>>>>>>>>>>> variable declair <<<<<<<<<<<< //
final nu = null;
String _email = '';
String _password = '';
final FirebaseAuth auth = FirebaseAuth.instance;
bool eye = true;
var _user = auth.currentUser;
// var useremail = _user?.email;
bool changebutton = false;
String name = "";
final _formkey1 = GlobalKey<FormState>();
TextEditingController userctrl = TextEditingController();
TextEditingController pwdctrl = TextEditingController();

//!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> start main class <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//

class _SigninState extends State<Signin> {
  // Future signinwithgoogle() async {
  //   await Authentification().signinwithgoogle();
  // }

  @override
  Widget build(BuildContext context) {
    // String? _useremail =
    //     Provider.of<Authentication>(context, listen: true).useremail;
    Future<dynamic>? _userquery =
        Provider.of<CheckADM>(context, listen: false).getADM();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey1,
          child: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage('assets/gif/8408-app-background.gif')),
            // ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 250,
                  width: 400,
                  child: Lottie.asset(
                      'assets/gif/71676-ui-and-ux-design-isometric-animation.json'),
                ),
                SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome back Foodies",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cascadia',
                          ),
                        ),
                        Image.asset('assets/images/giphy.gif')
                      ],
                    )),

                //todo <---------------------- start first textformfield --------------------------------->

                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: TextFormField(
                      cursorColor: Colors.deepPurple,
                      controller: userctrl,
                      textAlign: TextAlign.start,

                      // <----------------------start second inputdecoration-------------------------->

                      decoration: InputDecoration(
                          focusColor: Colors.red,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintStyle: TextStyle(color: Colors.deepPurple),
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          labelText: "Email id",
                          hintText: "Email id",
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2)),
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
                          _email = value.trimRight();
                        });
                      },
                    ),
                  ),
                ),

                //! <------------------------- end first textformfield textformfield --------------------->

                //todo <---------------------- start second textformfield --------------------------------->

                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: TextFormField(
                      cursorColor: Colors.deepPurple,
                      // cursorHeight: 25,
                      controller: pwdctrl,
                      textAlign: TextAlign.start,
                      obscureText: eye,

                      // <----------------------start second inputdecoration--------------------------------->

                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: "Password",
                          hintText: "password",
                          hintStyle: TextStyle(color: Colors.deepPurple),
                          labelStyle: TextStyle(color: Colors.deepPurple),
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
                          _password = value.trim();
                        });
                      },
                    ),
                  ),
                ),

                //! <------------------------ end second textformfield textformfield --------------------->

                //? +++++++++++++++++++++++++++++++++ end textformfield ++++++++++++++++++++++++++++++//

                // todo<---------------------------- start signin button -------------------------------------->

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: InkWell(
                      onTap: () {
                        if (_formkey1.currentState!.validate()) {
                          setState(() {});
                          return _signin(_email, _password);
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
                          "Login",
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
                ),

                //! <------------------------------ end signbutton -------------------------------------->

                //todo <--------------------------- forgot password button ------------------------------------>

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                  child: InkWell(
                    highlightColor: Colors.deepPurple,
                    hoverColor: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.deepPurple,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Preset();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: Colors.red,
                      ),
                      height: 30,
                      width: 320,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'reset password.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins'),
                            ),
                            Text(
                              "Forgot your password?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins'),
                            ),
                          ]),
                    ),
                  ),
                ),

                //! <--------------------------- end forgot password button ------------------------------------>

                //todo <---------------------- start go to signup page button --------------------------------->

                Material(
                  child: InkWell(
                    highlightColor: Colors.deepPurple,
                    hoverColor: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.deepPurple,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Signup();
                      }));
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
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins'),
                        ),
                      ),
                    ),
                  ),
                ),

                //! <---------------------- end go to signup page button --------------------------------->

//!xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx google signin start xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx//
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
                      borderRadius: BorderRadius.circular(26),
                      splashColor: Colors.deepPurple[400],
                      onTap: () {
                        print('${Provider.of<Authentication>(context, listen: false).useremail}' +
                            '-----------------------------------------------------------' +
                            '${Provider.of<CheckADM>(context, listen: false).getadm}');
                        Border.all();
                        BorderRadius.all(Radius.circular(30));
                        Provider.of<Authentication>(context, listen: false)
                            .signinwithgoogle(context)
                            .whenComplete(() {
                          if (auth.currentUser != null) {
                            print(_user!.email);

                            String success = 'Successfully Login';

                            // print(
                            //     '${Provider.of<CheckADM>(context, listen: false).getadm}');
                            showerrorsnackbar(context, success,
                                Icons.done_all_rounded, Colors.blue);

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
                            showerrorsnackbar(context, _errors,
                                Icons.error_outline, Colors.red);
                          }
                        });
                      },
                      child: Container(
                        child: sicon(),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.deepPurple),
                        ),
                      ),
                    )
                  ],
                )
//!xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx google signin over xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx//
              ],
            ),
          ),
        ),
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

  Expanded builddivider() {
    return Expanded(
      child: Divider(
        color: Colors.black,
        height: 1.5,
      ),
    );
  }

  getadm() async {
    // QuerySnapshot _snapshot = await FirebaseFirestore.instance
    //     .collection('admin')
    //     .where("email", isEqualTo: "rohanparmar1162@gmail.com")
    //     .get();
    // print(_snapshot);
    // return _snapshot.docs[0]['email'];
    return FirebaseFirestore.instance
        .collection('admin')
        .where("email", isEqualTo: "rohanparmar1162@gmail.com")
        .get();
  }

  //todo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> signin auth <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

  _signin(String _email, String _password) async {
    String notverify = 'please verify email';
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);

      //?>>>>>>>>>>> if success <<<<<<<<<<<<<<//

      if (_user!.emailVerified) {
        String success = 'Successfully Login';
        showerrorsnackbar(
            context, success, Icons.done_all_rounded, Colors.blue);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          if (_user!.email == 'rohanparmar1162@gmail.com') {
            print('admin');
            return Adminscreen();
          } else if (_user!.email == 'project331563@gmail.com') {
            return Deliveryboyscreen();
          } else {
            return Bottombarpage();
          }
        }), (route) => false).whenComplete(() {
          setdata();
        });
      } else {
        showerrorsnackbar(context, notverify, Icons.error_outline, Colors.red);
        Timer(
            Duration(seconds: 3),
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Verify()),
                (route) => false));
      }
    }

    //?>>>>>>>>>>> else show error <<<<<<<<<<<<<<//

    on FirebaseAuthException catch (e) {
      final err = e.message;

      print(err);
      showerrorsnackbar(context, err, Icons.error_outline, Colors.red);
    }
  }
}

//todo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> message snackbar <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //
//!xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx google icon start xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx//

Icon sicon() {
  return Icon(
    EvaIcons.google,
    color: Colors.deepPurple,
  );
}

//!xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx google icon over xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx//
void showerrorsnackbar(BuildContext context, err, iconname, colorname) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            color: Colors.black,
            // strokeWidth: 1,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          iconname,
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
    backgroundColor: colorname,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 3),
    margin: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 15,
  );

  ScaffoldMessenger.of(context)..hideCurrentSnackBar();
  ScaffoldMessenger.of(context)..showSnackBar(snackBar);
}

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

//! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> End  message snackbar <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

//? +++++++++++++++++++++++++++++++++++++   end all function  ++++++++++++++++++++++++++++++++++++++++//

//* * eye icon for password working function //

void eyechange() {
  if (eye == true) {
    eye = false;
  } else {
    eye = true;
  }
}
