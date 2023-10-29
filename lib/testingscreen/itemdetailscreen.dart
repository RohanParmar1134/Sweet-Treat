import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/screen/all_main_screen/cart.dart';

class Detailscreen extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  Detailscreen({required this.queryDocumentSnapshot});

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  User? firebaseuser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // int? quantity;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0,
          title: Text(widget.queryDocumentSnapshot['title']),
          centerTitle: true,
          actions: [
            Badge(
              badgeContent: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc('${firebaseuser?.uid}')
                    .collection('items')
                    .where('quantity', isGreaterThan: 0)
                    .snapshots(),
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              badgeAnimation: BadgeAnimation.fade(animationDuration: Duration(seconds: 2)),
              // badgeColor: Colors.white,
              // animationType: BadgeAnimationType.fade,
              // animationDuration: Duration(seconds: 2),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Cart();
                    }));
                  },
                  icon: Icon(CupertinoIcons.cart, color: Colors.white)),
            )
          ],
        ),
        body: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  color: Colors.orange[300],
                ),
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.92,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.queryDocumentSnapshot['bcimage'])),
                          // color: Colors.orange,
                        ),
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.queryDocumentSnapshot['title']} ",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                              Text(
                                "₹" +
                                    "${widget.queryDocumentSnapshot['price']}   ",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Text(
                            "${widget.queryDocumentSnapshot['weight']}",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                        child: Container(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc('${firebaseuser?.uid}')
                              .collection('items')
                              .where('id',
                                  isEqualTo: widget.queryDocumentSnapshot['id'])
                              .where('quantity', isGreaterThan: 0)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Text('no data');
                            } else if (snapshot.connectionState ==
                                ConnectionState.none) {
                              return CircularProgressIndicator();
                            } else {
                              int isdata = snapshot.data.docs.length;
                              return Container(
                                child: Column(
                                  children: [
                                    isdata != 0
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.red[600],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    height: 50,
                                                    width: 100,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: snapshot
                                                          .data.docs.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Row(
                                                          children: [
                                                            IconButton(
                                                                color: Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(
                                                                          '${firebaseuser?.uid}')
                                                                      .collection(
                                                                          'items')
                                                                      .doc(
                                                                          '${widget.queryDocumentSnapshot['id']}')
                                                                      .update({
                                                                    'quantity':
                                                                        FieldValue
                                                                            .increment(-1)
                                                                  }).whenComplete(
                                                                          () {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(
                                                                            '${firebaseuser?.uid}')
                                                                        .collection(
                                                                            'total')
                                                                        .doc(
                                                                            'total-123')
                                                                        .update({
                                                                      'total': FieldValue.increment(
                                                                          -widget
                                                                              .queryDocumentSnapshot['price'])
                                                                    });
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                    EvaIcons
                                                                        .minus)),
                                                            Text(
                                                              '${snapshot.data.docs[0]['quantity']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            IconButton(
                                                                color: Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(
                                                                          '${firebaseuser?.uid}')
                                                                      .collection(
                                                                          'items')
                                                                      .doc(
                                                                          '${widget.queryDocumentSnapshot['id']}')
                                                                      .update({
                                                                    'quantity':
                                                                        FieldValue
                                                                            .increment(1)
                                                                  }).whenComplete(
                                                                          () {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(
                                                                            '${firebaseuser?.uid}')
                                                                        .collection(
                                                                            'total')
                                                                        .doc(
                                                                            'total-123')
                                                                        .update({
                                                                      'total': FieldValue.increment(
                                                                          widget
                                                                              .queryDocumentSnapshot['price'])
                                                                    });
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                    EvaIcons
                                                                        .plus)),
                                                          ],
                                                        );
                                                      },
                                                    )),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  CupertinoIcons.delete,
                                                  size: 35,
                                                ),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(
                                                          '${firebaseuser?.uid}')
                                                      .collection('items')
                                                      .doc(
                                                          '${widget.queryDocumentSnapshot['id']}')
                                                      .update({
                                                    'quantity': 0,
                                                  }).whenComplete(() {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(
                                                            '${firebaseuser?.uid}')
                                                        .collection('total')
                                                        .doc('total-123')
                                                        .update({
                                                      'total': FieldValue
                                                          .increment(-widget
                                                                  .queryDocumentSnapshot[
                                                              'price'])
                                                    });
                                                  });
                                                },
                                              )
                                            ],
                                          )
                                        : Container(
                                            child: CupertinoButton(
                                                color: Colors.red[600],
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(
                                                          '${firebaseuser?.uid}')
                                                      .collection('items')
                                                      .doc(
                                                          '${widget.queryDocumentSnapshot['id']}')
                                                      .set({
                                                    'title':
                                                        '${widget.queryDocumentSnapshot['title']}',
                                                    'bcimage':
                                                        '${widget.queryDocumentSnapshot['bcimage']}',
                                                    'id':
                                                        '${widget.queryDocumentSnapshot['id']}',
                                                    'quantity': 1,
                                                    'weight': widget
                                                            .queryDocumentSnapshot[
                                                        'weight'],
                                                    'stock': widget
                                                            .queryDocumentSnapshot[
                                                        'stock'],
                                                    "price": widget
                                                            .queryDocumentSnapshot[
                                                        'price'],
                                                    "status": "Order Placed"
                                                  }).whenComplete(() {
                                                    print(widget
                                                            .queryDocumentSnapshot[
                                                        'price']);

                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(
                                                            '${firebaseuser?.uid}')
                                                        .collection('total')
                                                        .doc('total-123')
                                                        .update({
                                                      'total': FieldValue
                                                          .increment(widget
                                                                  .queryDocumentSnapshot[
                                                              'price'])
                                                    });
                                                  });
                                                },
                                                child: Text('ADD')),
                                          ),
                                  ],
                                ),
                              );
                            }
                          }),
                    ))
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ]),
        ));
  }
}
