import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/admin/productdetailbyorderid.dart';

class Userpendingorderdata extends StatefulWidget {
  final String queryDocumentSnapshot;
  Userpendingorderdata({required this.queryDocumentSnapshot});

  @override
  State<Userpendingorderdata> createState() => _UserpendingorderdataState();
}

class _UserpendingorderdataState extends State<Userpendingorderdata> {
  @override
  Widget build(BuildContext context) {
    var _firebaseuser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('order')
                .doc('${widget.queryDocumentSnapshot}')
                .collection('pendingorder')
                .where('approved', isEqualTo: false)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('no data'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print(snapshot.data.docs.length);
              return Container(
                // color: Colors.green,
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Productdetailbyorderid(
                              queryDocumentSnapshot1:
                                  snapshot.data.docs[index].id,
                              queryDocumentSnapshot2:
                                  widget.queryDocumentSnapshot,
                            );
                          }));
                        },
                        child: Container(
                          height: 60,
                          color: Colors.yellow,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Oid : " +
                                  "${snapshot.data.docs[index]['orderid']}"),
                              Text("Date : " +
                                  "${snapshot.data.docs[index]['date']}"),
                              Text("Items : " +
                                  "${snapshot.data.docs[index]['items']}"),
                              Text("${snapshot.data.docs[index]['total']}" +
                                  "rs")
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
