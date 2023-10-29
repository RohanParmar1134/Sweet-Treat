import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/google_maps.dart';

class Myorderdetail extends StatefulWidget {
  final String queryDocumentSnapshot;
  Myorderdetail({required this.queryDocumentSnapshot});

  @override
  State<Myorderdetail> createState() => _MyorderdetailState();
}

class _MyorderdetailState extends State<Myorderdetail> {
  @override
  Widget build(BuildContext context) {
    // var docid;
    var _firebaseuser = FirebaseAuth.instance.currentUser;
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('${_firebaseuser?.uid}')
    //     .collection('myorder')
    //     .get()
    //     .then((value) {
    //   value.docs.forEach((element) {
    //     docid = element.id;
    //     print(docid);
    //     FirebaseFirestore.instance
    //         .collection('users')
    //         .doc('${_firebaseuser?.uid}')
    //         .collection('myorder')
    //         .doc(docid)
    //         .collection('subcoll')
    //         .get()
    //         .then((value) {
    //       print(value.docs);
    //     });
    //   });
    // });

    return Scaffold(
      body: Center(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc('${_firebaseuser?.uid}')
                .collection('myorder')
                .doc('${widget.queryDocumentSnapshot}')
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

              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Card(
                        shadowColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 8,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    child: Image(
                                      image: NetworkImage(
                                          "${snapshot.data.docs[index]['bcimage']}"),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data.docs[index]['title']}",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'poppins'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Total Items : " +
                                        "${snapshot.data.docs[index]['quantity']}",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'poppins'),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Price : " +
                                            "₹" +
                                            "${snapshot.data.docs[index]['price']}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'poppins'),
                                      ),
                                      Text(
                                        "Total : " +
                                            "₹" +
                                            "${snapshot.data.docs[index]['price'] * snapshot.data.docs[index]['quantity']}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'poppins'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
