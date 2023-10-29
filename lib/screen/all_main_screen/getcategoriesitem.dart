import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:online_bakery_shop/testingscreen/itemdetailscreen.dart';

class Getcategoriesitems extends StatefulWidget {
  final String? itemname;
  Getcategoriesitems({required this.itemname});

  @override
  State<Getcategoriesitems> createState() => _GetcategoriesitemsState();
}

class _GetcategoriesitemsState extends State<Getcategoriesitems> {
  @override
  Widget build(BuildContext context) {
    print('${widget.itemname}' + '-id123');
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('allcategories')
                .doc('${widget.itemname}' + '-id123')
                .collection('${widget.itemname}')
                .where('stock', isNotEqualTo: "")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                color: Colors.amber,
                height: 240,
                // width: 600,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Card(
                                shadowColor: Colors.orange[200],
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  splashColor: Colors.orange[500],
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Detailscreen(
                                          queryDocumentSnapshot:
                                              snapshot.data.docs[index]);
                                    }));
                                    // print(snapshot.data.docs[index]['title']);
                                    // print(snapshot.data.docs[index]['bcimage']);
                                  },
                                  child: Container(
                                    height: 270,
                                    width: 350,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            height: 200,
                                            child: Image.network(
                                              snapshot.data.docs[index]
                                                  ['bcimage'],
                                              fit: BoxFit.scaleDown,
                                            )),
                                        // CircleAvatar(
                                        //     backgroundImage: NetworkImage(
                                        //         snapshot.data.docs[index]
                                        //             ['bcimage'])),
                                        Text(
                                          // snapshot.data.docs[index]['title'],
                                          snapshot.data.docs[index]['title'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]);
                    }),
              );
            },
          ),
        ),
        // TextButton(
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) {
        //         return Testing2();
        //       }));
        //     },
        //     child: Text("upload image"))
      ],
    );
  }
}
