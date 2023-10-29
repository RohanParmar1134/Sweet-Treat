import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/admin/dpendinguserinfo.dart';

class Dpending extends StatelessWidget {
  const Dpending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delviery Pending Order"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('deliveryboy')
            .doc('gj91tkQ6YATLUxqJZZhp4CkvZhk2')
            .collection('otd')
            .where('pendingorder', isNotEqualTo: 0)
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Dpendinguserinfo(
                        useremail: "${snapshot.data.docs[index]['email']}",
                      );
                    }));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.amber,
                    child: Center(
                      child: Text(snapshot.data.docs[index]['email']),
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
