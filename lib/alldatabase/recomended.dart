import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/testingscreen/itemdetailscreen.dart';

class Recomended extends StatefulWidget {
  const Recomended({
    Key? key,
  }) : super(key: key);

  @override
  _RecomendedState createState() => _RecomendedState();
}

class _RecomendedState extends State<Recomended> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('homecategories').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            // color: Colors.grey,
            height: 240,
            // width: 600,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Card(
                            shadowColor: Colors.orange[200],
                            elevation: 5,
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
                                print(snapshot.data.docs[index]['title']);
                                print(snapshot.data.docs[index]['bcimage']);
                              },
                              child: Container(
                                height: 200,
                                width: 170,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 150,
                                      child: Image.network(
                                          snapshot.data.docs[index]['bcimage'],
                                          fit: BoxFit.scaleDown),
                                    ),
                                    // CircleAvatar(
                                    //     backgroundImage: NetworkImage(
                                    //         snapshot.data.docs[index]
                                    //             ['bcimage'])),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            snapshot.data.docs[index]['title'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ]),
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
    );
  }
}
