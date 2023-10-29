import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Preset extends StatefulWidget {
  const Preset({Key? key}) : super(key: key);

  @override
  _PresetState createState() => _PresetState();
}

String _email = nu;
final nu = null;
final _auth = FirebaseAuth.instance;

class _PresetState extends State<Preset> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 10,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'forgot password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      cursorColor: Colors.orange,

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
                          labelText: "Email id",
                          hintText: "Email id",
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                            CupertinoIcons.profile_circled,
                            color: Colors.orange,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter Email id";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value.trim();
                        });
                      },
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 25, 0),
                      child: InkWell(
                        highlightColor: Colors.orange,
                        hoverColor: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                        splashColor: Colors.orange,
                        onTap: () async {
                          setState(() {});
                          if (_email == nu) {
                            // Fluttertoast.showToast(msg: "please enter email");
                          } else {
                            try {
                              await _auth.sendPasswordResetEmail(email: _email);
                              Navigator.of(context).pop();
                            } on FirebaseAuthException catch (e) {
                              final error = e;
                              print(error);
                              Fluttertoast.showToast(msg: '$error');
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orange,
                                  width: 2,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.red,
                            ),
                            height: 30,
                            width: 280,
                            child: Center(
                              child: Text(
                                "Send verification link to this email",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'poppins'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
