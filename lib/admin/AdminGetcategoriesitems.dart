import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_bakery_shop/testingscreen/itemdetailscreen.dart';

class AdminGetcategoriesitems extends StatefulWidget {
  final String? itemname;
  AdminGetcategoriesitems({required this.itemname});

  @override
  State<AdminGetcategoriesitems> createState() =>
      _AdminGetcategoriesitemsState();
}

TextEditingController _namectrl = TextEditingController();
TextEditingController _stockctrl = TextEditingController();
TextEditingController _pricectrl = TextEditingController();
final _formkey1 = GlobalKey<FormState>();
String? _name;
String? _stock;
String? _price;
String? itemselect;

class _AdminGetcategoriesitemsState extends State<AdminGetcategoriesitems> {
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
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                color: Colors.white,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            // snapshot.data.docs[index]['title'],
                                            "${snapshot.data.docs[index]['price']}" +
                                                "rs",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w500),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                itemselect = snapshot
                                                    .data.docs[index].id;

                                                print(itemselect);
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        priceedititem(
                                                            snapshot));
                                              },
                                              icon: Icon(Icons.edit)),
                                          Text(
                                            // snapshot.data.docs[index]['title'],
                                            snapshot.data.docs[index]['stock'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w500),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                itemselect = snapshot
                                                    .data.docs[index].id;

                                                print(itemselect);
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        stockedititem(
                                                            snapshot));
                                              },
                                              icon: Icon(Icons.edit)),
                                          Flexible(
                                            child: Text(
                                              // snapshot.data.docs[index]['title'],
                                              snapshot.data.docs[index]
                                                  ['title'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                itemselect = snapshot
                                                    .data.docs[index].id;

                                                print(itemselect);
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        titleedititem(
                                                            snapshot));
                                              },
                                              icon: Icon(Icons.edit))
                                        ],
                                      ),
                                    ],
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

  Widget titleedititem(dynamic snapshot) => Container(
        child: Form(
          key: _formkey1,
          child: Column(
            children: [
              Row(children: [
                Text(
                  "Name :",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: _namectrl,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: "Item Name",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Name";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(
                  child: CupertinoButton(
                      color: Colors.blue,
                      child: Text("Save"),
                      onPressed: () {
                        if (_formkey1.currentState!.validate()) {
                          setState(() {
                            _titlesavetofirebase();
                          });
                        } else {
                          setState(() {});
                          return null;
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      );
  Widget stockedititem(dynamic snapshot) => Container(
        child: Form(
            key: _formkey1,
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(children: [
                      Text(
                        "Stock :",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: _stockctrl,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.orange, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Stock",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppins'),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _stock = value;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(
                  child: CupertinoButton(
                      color: Colors.blue,
                      child: Text("Save"),
                      onPressed: () {
                        if (_formkey1.currentState!.validate()) {
                          setState(() {
                            _stockdeletesavetofirebase();
                          });
                        } else {
                          setState(() {});
                          return null;
                        }
                      }),
                ),
              )
            ])),
      );
  Widget priceedititem(dynamic snapshot) => Container(
      child: Form(
          key: _formkey1,
          child: Column(children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(children: [
                        Text(
                          "Price :",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _pricectrl,
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: "Price",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins'),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Price";
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                _price = value;
                              });
                            },
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Center(
                    child: CupertinoButton(
                        color: Colors.blue,
                        child: Text("Save"),
                        onPressed: () {
                          if (_formkey1.currentState!.validate()) {
                            setState(() {
                              _pricesavetofirebase();
                            });
                          } else {
                            setState(() {});
                            return null;
                          }
                        }),
                  ),
                )
              ],
            ),
          ])));

  _titlesavetofirebase() async {
    await FirebaseFirestore.instance
        .collection('allcategories')
        .doc('${widget.itemname}' + '-id123')
        .collection('${widget.itemname}')
        .doc('${itemselect}')
        .update({"title": _name});
  }

  _stockdeletesavetofirebase() async {
    await FirebaseFirestore.instance
        .collection('allcategories')
        .doc('${widget.itemname}' + '-id123')
        .collection('${widget.itemname}')
        .doc('${itemselect}')
        .update({"stock": _stock});
  }

  _pricesavetofirebase() async {
    await FirebaseFirestore.instance
        .collection('allcategories')
        .doc('${widget.itemname}' + '-id123')
        .collection('${widget.itemname}')
        .doc('${itemselect}')
        .update({"price": int.parse(_price!)});
  }
}
