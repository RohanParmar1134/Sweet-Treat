import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dpendinguserinfo extends StatefulWidget {
  final String useremail;
  Dpendinguserinfo({required this.useremail});

  @override
  State<Dpendinguserinfo> createState() => _DpendinguserinfoState();
}

class _DpendinguserinfoState extends State<Dpendinguserinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery pending user"),
      ),
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
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.amber,
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
                        Text("Payment: " +
                            "${snapshot.data.docs[index]['Payment']}"),
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
