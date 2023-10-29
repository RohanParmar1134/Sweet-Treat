import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online_bakery_shop/screen/all_main_screen/myorderdetail.dart';
import 'package:provider/provider.dart';

class Myorder extends StatelessWidget {
  const Myorder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _user = FirebaseAuth.instance.currentUser;
    num? itemcount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc('${_user?.uid}')
                .collection('myorder')
                .where("total", isGreaterThan: 0)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('no data'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Provider.of<Itemcount>(context, listen: false)
                          //     .getitemcount(_user, snapshot, index);
                          // getitemcount(_user, snapshot, index, itemcount);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            child: Card(
                              shadowColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 8,
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                    color: Colors.orange[200],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Total Items : " +
                                              "${snapshot.data.docs[index]['items']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'poppins'),
                                        ),
                                        Text(
                                          "Total : " +
                                              "₹" +
                                              "${snapshot.data.docs[index]['total']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'poppins'),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Staus : " +
                                                  "${snapshot.data.docs[index]['status']}",
                                              style: TextStyle(
                                                  fontFamily: 'poppins'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Order Date : " +
                                                  "${snapshot.data.docs[index]['date']}",
                                              style: TextStyle(
                                                  fontFamily: 'poppins'),
                                            )
                                          ],
                                        ),
                                        InkWell(

                                            // color: Colors.red,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                6))),
                                                height: 40,
                                                width: 130,
                                                child: Center(
                                                    child: Text(
                                                  "View Details",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'poppins'),
                                                ))),
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return Myorderdetail(
                                                  queryDocumentSnapshot:
                                                      snapshot
                                                          .data.docs[index].id,
                                                );
                                              }));
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Itemcount extends ChangeNotifier {
  num? itemcount;
  getitemcount(_user, snapshot, index) async {
    itemcount = await FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('myorder')
        .doc('${snapshot.data.docs[index].id}')
        .collection('subcoll')
        .get()
        .then((value) {
      return itemcount = value.docs.length;
    });
  }

  // num? get getcount => itemcount;
}
