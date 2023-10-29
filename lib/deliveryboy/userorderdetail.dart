import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Userorderdetail extends StatefulWidget {
  final String useremail;
  Userorderdetail({required this.useremail});

  @override
  State<Userorderdetail> createState() => _UserorderdetailState();
}

class _UserorderdetailState extends State<Userorderdetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('deliveryboy')
            .doc('gj91tkQ6YATLUxqJZZhp4CkvZhk2')
            .collection('otd')
            .doc('${widget.useremail}')
            .collection('dorders')
            .where("dstatus", isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('no data'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber,
                    ),
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Oid: " +
                                "${snapshot.data.docs[index]['orderid']}"),
                            Text("Total: " +
                                "${snapshot.data.docs[index]['total']}" +
                                "rs"),
                            Text("Items: " +
                                "${snapshot.data.docs[index]['items']}"),
                            Text("Date: " +
                                "${snapshot.data.docs[index]['date']}"),
                          ],
                        ),
                        Flexible(
                            child: Text(
                          "Address: " +
                              "${snapshot.data.docs[index]['address']}",
                          maxLines: 6,
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CupertinoButton(
                                    color: Colors.red,
                                    child: Text("Open Map"),
                                    onPressed: () {
                                      // openmap(27.173891, 78.042068);
                                      launch(
                                          "https://www.google.com/maps/search/?api=1&query=${snapshot.data.docs[index]['lat']},${snapshot.data.docs[index]['log']}");
                                    }),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: CupertinoButton(
                                      color: Colors.blue,
                                      child: Text("Delivered"),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('deliveryboy')
                                            .doc('gj91tkQ6YATLUxqJZZhp4CkvZhk2')
                                            .collection('otd')
                                            .doc('${widget.useremail}')
                                            .collection('dorders')
                                            .doc(
                                                '${snapshot.data.docs[index]['orderid']}')
                                            .update({
                                          "dstatus": true
                                        }).whenComplete(() async {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(
                                                  '${snapshot.data.docs[index]['uid']}')
                                              .collection('myorder')
                                              .doc(
                                                  '${snapshot.data.docs[index]['orderid']}')
                                              .update({
                                            "status": "Delivered"
                                          }).whenComplete(() async {
                                            await FirebaseFirestore.instance
                                                .collection('deliveryboy')
                                                .doc(
                                                    'gj91tkQ6YATLUxqJZZhp4CkvZhk2')
                                                .collection('otd')
                                                .doc(
                                                    '${snapshot.data.docs[index]['email']}')
                                                .collection('dorders')
                                                .where('dstatus',
                                                    isEqualTo: false)
                                                .get()
                                                .then((value) async {
                                              if (value.docs.length == null ||
                                                  value.docs.length == 0) {
                                                await FirebaseFirestore.instance
                                                    .collection('deliveryboy')
                                                    .doc(
                                                        'gj91tkQ6YATLUxqJZZhp4CkvZhk2')
                                                    .collection('otd')
                                                    .doc(
                                                        '${snapshot.data.docs[index]['email']}')
                                                    .update(
                                                        {'pendingorder': 0});
                                              } else {
                                                await FirebaseFirestore.instance
                                                    .collection('deliveryboy')
                                                    .doc(
                                                        'gj91tkQ6YATLUxqJZZhp4CkvZhk2')
                                                    .collection('otd')
                                                    .doc(
                                                        '${snapshot.data.docs[index]['email']}')
                                                    .update({
                                                  'pendingorder':
                                                      value.docs.length
                                                });
                                              }
                                            });
                                          });
                                        });
                                      }),
                                ),
                              ],
                            ),
                            Text("Payment: " +
                                "${snapshot.data.docs[index]['Payment']}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
