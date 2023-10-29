// import 'package:firebase/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';
import 'package:online_bakery_shop/screen/all_main_screen/cart.dart';

class Phoneno extends StatefulWidget {
  const Phoneno({Key? key}) : super(key: key);

  @override
  State<Phoneno> createState() => _PhonenoState();
}

var _OTP;
String? _phoneno;

final _formkey2 = GlobalKey<FormState>();
final _formkey1 = GlobalKey<FormState>();
TextEditingController userctrl = TextEditingController();
TextEditingController otpctrl = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;
void signInWIthPhoneAuthCredential(
    PhoneAuthCredential phoneAuthCredential) async {
  try {
    final authcredential = await auth.signInWithCredential(phoneAuthCredential);
    if (authcredential.user != null) {
      print("success verify");
    }
  } on FirebaseAuthException catch (e) {
    print(e);
  }
}

class _PhonenoState extends State<Phoneno> {
  String verificationid = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formkey1,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: TextFormField(
                    cursorColor: Colors.orange,
                    controller: userctrl,
                    textAlign: TextAlign.start,

                    // <----------------------start second inputdecoration-------------------------->

                    decoration: InputDecoration(
                        focusColor: Colors.red,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintStyle: TextStyle(color: Colors.orange),
                        labelStyle: TextStyle(color: Colors.orange),
                        labelText: "Phone Number",
                        hintText: "Phone Number",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        icon: Icon(
                          CupertinoIcons.phone,
                          color: Colors.orange,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter Phone no";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _phoneno = value.trimRight();
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: InkWell(
                  onTap: () {
                    if (_formkey1.currentState!.validate()) {
                      setState(() {});
                      phonenoverify();
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
                      "Generate OTP",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                      ),
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
            Form(
              key: _formkey2,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: TextFormField(
                    cursorColor: Colors.orange,
                    controller: otpctrl,
                    textAlign: TextAlign.start,

                    // <----------------------start second inputdecoration-------------------------->

                    decoration: InputDecoration(
                        focusColor: Colors.red,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintStyle: TextStyle(color: Colors.orange),
                        labelStyle: TextStyle(color: Colors.orange),
                        labelText: "OTP",
                        hintText: "OTP",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        icon: Icon(
                          CupertinoIcons.phone,
                          color: Colors.orange,
                        )),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return "please enter OTP";
                    //   }
                    //   return null;
                    // },
                    onChanged: (value) {
                      setState(() {
                        _OTP = value.trimRight();
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: InkWell(
                  onTap: () {
                    if (_formkey2.currentState!.validate()) {
                      setState(() {});
                      verifyphone();
                      showsuccesssnackbar(context, "Successfull Added Number");
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
                        fontSize: 18,
                        fontFamily: 'poppins',
                      ),
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
          ],
        ),
      ),
    );
  }

  phonenoverify() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + '$_phoneno',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        this.verificationid = verificationId;
        // String smsCode = _OTP;

        // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: verificationId, smsCode: smsCode);

        // // Sign the user in (or link) with the credential
        // await auth
        //     .signInWithCredential(credential)
        //     .whenComplete(() => print("success phone number"));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyphone() async {
    print(firebaseuser?.uid);

    print(otpctrl.text);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationid, smsCode: otpctrl.text);
    try {
      Navigator.pop(context);
      print(firebaseuser?.uid);
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${firebaseuser?.uid}')
          .collection('total')
          .doc('total-123')
          .update({"phoneno": userctrl.text});
      // final authcredential =
      //     await auth.signInWithCredential(phoneAuthCredential);
      // if (authcredential.user != null) {

      // }
      print("success verify");
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    // await auth.signInWithCredential(phoneAuthCredential);
  }
}
