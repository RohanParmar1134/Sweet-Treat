import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/google_maps.dart';

class Productdetailbyorderid extends StatefulWidget {
  final String queryDocumentSnapshot1, queryDocumentSnapshot2;
  Productdetailbyorderid(
      {required this.queryDocumentSnapshot1,
      required this.queryDocumentSnapshot2});

  @override
  _ProductdetailbyorderidState createState() => _ProductdetailbyorderidState();
}

User? _user = FirebaseAuth.instance.currentUser;
String? _email;

class _ProductdetailbyorderidState extends State<Productdetailbyorderid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('order')
              .doc('${widget.queryDocumentSnapshot2}')
              .collection('pendingorder')
              .doc('${widget.queryDocumentSnapshot1}')
              .collection('subcoll')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('no data'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // Timer(Duration(seconds: 2), () {});
            return Stack(
              children: [
                Container(
                  // color: Colors.black,
                  // height: 600,
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      // print(snapshot.data.docs.length);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10)),
                          height: 90,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                child: Image(
                                    image: NetworkImage(
                                        "${snapshot.data.docs[index]['bcimage']}")),
                              ),
                              Text("${snapshot.data.docs[index]['title']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'poppins')),
                              Text(
                                  "${snapshot.data.docs[index]['quantity']}" +
                                      " qty",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'poppins')),
                              Text(
                                  "${snapshot.data.docs[index]['price']}" +
                                      "rs",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'poppins')),
                              Text("${snapshot.data.docs[index]['weight']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'poppins')),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(10))),

                      // height: MediaQuery.of(context).size.height,
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('order')
                            .doc('${widget.queryDocumentSnapshot2}')
                            .collection('pendingorder')
                            .doc('${widget.queryDocumentSnapshot1}')
                            .snapshots(),
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
                          return Container(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Address : " +
                                        "${snapshot.data['address']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'poppins'),
                                    maxLines: 6,
                                  ),
                                ),
                                Text("Date : " + "${snapshot.data['date']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'poppins')),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CupertinoButton(
                                        color: Colors.blue,
                                        child: Text(
                                          'Approve',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'poppins'),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await FirebaseFirestore.instance
                                              .collection('order')
                                              .doc(
                                                  '${widget.queryDocumentSnapshot2}')
                                              .collection('pendingorder')
                                              .doc(
                                                  '${widget.queryDocumentSnapshot1}')
                                              .get()
                                              .then((value) async {
                                            await FirebaseFirestore.instance
                                                .collection('deliveryboy')
                                                .doc(
                                                    'gj91tkQ6YATLUxqJZZhp4CkvZhk2')
                                                .collection('otd')
                                                .doc(
                                                    '${value.data()!['email']}')
                                                .set({
                                              "email":
                                                  "${value.data()!['email']}"
                                            }).whenComplete(() async {
                                              _email = value.data()!['email'];
                                              await FirebaseFirestore.instance
                                                  .collection('deliveryboy')
                                                  .doc(
                                                      'gj91tkQ6YATLUxqJZZhp4CkvZhk2')
                                                  .collection('otd')
                                                  .doc(
                                                      '${value.data()!['email']}')
                                                  .collection('dorders')
                                                  .doc(
                                                      '${value.data()!['orderid']}')
                                                  .set({
                                                "address":
                                                    "${value.data()!['address']}",
                                                "lat": value.data()!['lat'],
                                                "log": value.data()!['log'],
                                                "uid": value.data()!['uid'],
                                                "phoneno":
                                                    value.data()!['phoneno'],
                                                "items": value.data()!['items'],
                                                "orderid":
                                                    value.data()!['orderid'],
                                                "total": value.data()!['total'],
                                                "date":
                                                    "${value.data()!['date']}",
                                                "email":
                                                    "${value.data()!['email']}",
                                                "dstatus": false,
                                                "Payment":
                                                    "${value.data()!['Payment']}"
                                              }).whenComplete(() async {
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(
                                                        '${widget.queryDocumentSnapshot2}')
                                                    .collection('myorder')
                                                    .doc(
                                                        '${widget.queryDocumentSnapshot1}')
                                                    .update(
                                                        {"status": "Making"});
                                              }).whenComplete(() {
                                                FirebaseFirestore.instance
                                                    .collection('order')
                                                    .doc(
                                                        '${widget.queryDocumentSnapshot2}')
                                                    .collection('pendingorder')
                                                    .doc(
                                                        '${widget.queryDocumentSnapshot1}')
                                                    .update({"approved": true});
                                              }).whenComplete(() async {
                                                await FirebaseFirestore.instance
                                                    .collection('deliveryboy')
                                                    .doc(
                                                        'gj91tkQ6YATLUxqJZZhp4CkvZhk2')
                                                    .collection('otd')
                                                    .doc('$_email')
                                                    .collection('dorders')
                                                    .where('dstatus',
                                                        isEqualTo: false)
                                                    .get()
                                                    .then((value) async {
                                                  if (value.docs.length ==
                                                          null ||
                                                      value.docs.length == 0) {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'deliveryboy')
                                                        .doc(
                                                            'gj91tkQ6YATLUxqJZZhp4CkvZhk2')
                                                        .collection('otd')
                                                        .doc('${['email']}')
                                                        .update({
                                                      'pendingorder': 0
                                                    });
                                                  } else {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'deliveryboy')
                                                        .doc(
                                                            'gj91tkQ6YATLUxqJZZhp4CkvZhk2')
                                                        .collection('otd')
                                                        .doc('$_email')
                                                        .update({
                                                      'pendingorder':
                                                          value.docs.length
                                                    });
                                                  }
                                                });
                                              });
                                            });
                                          });
                                        }),
                                    Column(
                                      children: [
                                        Text(
                                          "Total : " +
                                              "${snapshot.data['total']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'poppins'),
                                        ),
                                        Text(
                                          "Total : " +
                                              "${snapshot.data['Payment']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'poppins'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
