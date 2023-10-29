import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:online_bakery_shop/provider/maps.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/phoneno.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/google_maps.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

User? firebaseuser = FirebaseAuth.instance.currentUser;

class _CartState extends State<Cart> {
  Razorpay? _razorpay;

  @override
  void initState() {
    _razorpay = new Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.initState();
  }

  handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("payment ---- success");
    // savetomyorder();
    _onPressed("paid");
    String err = "Payment Success";
    showsuccesssnackbar(context, err, Colors.blue);
  }

  handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("payment ---- error");
    String err = "Payment Error";
    showsuccesssnackbar(context, err, Colors.red);
  }

  handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print("payment ---- wallet");
  }

  @override
  void dispose() {
    _razorpay?.clear();
    super.dispose();
  }

  gotopayment(String phoneno) async {
    num? amount = 0;
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${firebaseuser?.uid}')
        .collection('total')
        .doc('total-123')
        .get()
        .then((value) {
      amount = value.data()!['total'];
    });
    print(amount);
    var options = {
      'key': 'rzp_test_3LMrs967hJAUy3',
      'amount': amount! * 100,
      'name': '${firebaseuser?.email}',
      // 'order_id': 'order', // Generate order_id using Orders API
      'description': 'Bakery Items',
      'timeout': 300, // in seconds
      'prefill': {'contact': '$phoneno', 'email': '${firebaseuser?.email}'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      print("$e" + "------------------error");
    }
  }

  @override
  Widget build(BuildContext context) {
    num counter = 0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          'Cart',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
              onPressed: () {
                var db = FirebaseFirestore.instance
                    .collection('users')
                    .doc('${firebaseuser?.uid}')
                    .collection('items')
                    .get();
                db.then((value) async {
                  value.docs.forEach((element) {
                    element.reference.delete();
                  });
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc('${firebaseuser?.uid}')
                      .collection('total')
                      .doc('total-123')
                      .update({"total": 0});
                });
              },
              icon: Icon(CupertinoIcons.delete))
        ],
      ),
      body: Stack(
        children: [
          Container(
              color: Colors.orange[800],
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc('${firebaseuser?.uid}')
                          .collection('items')
                          .where('quantity', isGreaterThan: 0)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text('no data'));
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return snapshot.data.docs.length == 0
                            ? Container(
                                color: Colors.white,
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                        image: AssetImage(
                                            "assets/images/empty-cart-2130356-1800917.png")),
                                    Center(
                                      child: Text(
                                        "NO ITEMS",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.brown),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Stack(
                                children: [
                                  Container(
                                    height: 600,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          formethod(snapshot, index);

                                          print('${snapshot.data.docs.length}');
                                          return Card(
                                            child: Container(
                                              height: 90,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          // color: Colors.black,
                                                          width: 75,
                                                          child: Image(
                                                            image: NetworkImage(
                                                                snapshot.data
                                                                            .docs[
                                                                        index][
                                                                    'bcimage']),
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          )),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(
                                                          snapshot.data
                                                                  .docs[index]
                                                              ['title'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .brown[700],
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "poppins"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          color:
                                                              Colors.brown[700],
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
                                                                    '${snapshot.data.docs[index]['id']}')
                                                                .update({
                                                              'quantity':
                                                                  FieldValue
                                                                      .increment(
                                                                          -1)
                                                            }).whenComplete(() {
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
                                                                'total': FieldValue
                                                                    .increment(-snapshot
                                                                            .data
                                                                            .docs[index]
                                                                        [
                                                                        'price'])
                                                              });
                                                            });
                                                          },
                                                          icon: Icon(
                                                              EvaIcons.minus)),
                                                      Text(
                                                        '${snapshot.data.docs[index]['quantity']}',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .brown[700],
                                                            fontSize: 20),
                                                      ),
                                                      IconButton(
                                                          color:
                                                              Colors.brown[700],
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
                                                                    '${snapshot.data.docs[index]['id']}')
                                                                .update({
                                                              'quantity':
                                                                  FieldValue
                                                                      .increment(
                                                                          1)
                                                            }).whenComplete(() {
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
                                                                'total': FieldValue
                                                                    .increment(snapshot
                                                                            .data
                                                                            .docs[index]
                                                                        [
                                                                        'price'])
                                                              });
                                                            });
                                                          },
                                                          icon: Icon(
                                                              EvaIcons.plus)),
                                                      IconButton(
                                                          color:
                                                              Colors.brown[700],
                                                          onPressed: () {
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
                                                              'total': FieldValue.increment(-(snapshot
                                                                          .data
                                                                          .docs[index]
                                                                      [
                                                                      'quantity'] *
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'price']))
                                                            }).whenComplete(() {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(
                                                                      '${firebaseuser?.uid}')
                                                                  .collection(
                                                                      'items')
                                                                  .doc(
                                                                      '${snapshot.data.docs[index]['id']}')
                                                                  .update({
                                                                'quantity': 0,
                                                              });
                                                            });
                                                          },
                                                          icon: Icon(
                                                            CupertinoIcons
                                                                .delete,
                                                            color: Colors
                                                                .brown[700],
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              );
                      }),
                  Positioned(
                    bottom: 20,
                    left: 11,
                    right: 11,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),

                        // height: MediaQuery.of(context).size.height,
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc("${firebaseuser?.uid}")
                                  .collection('total')
                                  .doc('total-123')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('Loading');
                                } else if (snapshot.data['total'] == 0) {
                                  return Text('');
                                }

                                return Column(
                                  children: [
                                    Text(
                                      "${snapshot.data['total']}" + "rs",
                                      style: TextStyle(fontSize: 50),
                                    ),
                                    CupertinoButton(
                                        color: Colors.orange,
                                        child: Text("Place Order"),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  buildsheet(snapshot));
                                          // gotopayment();
                                        })
                                  ],
                                );
                              },
                            ),
                          ],
                        )),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  formethod(snapshot, index) {
    for (num quentitycount = 0;
        quentitycount <= snapshot.data.docs.length;
        quentitycount++) {
      quentitycount = quentitycount + snapshot.data.docs[index]['quantity'];
      print("$quentitycount" + "  quantity count");
    }
  }
  // savetomyorder() async {
  //   var db = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('${firebaseuser?.uid}')
  //       .collection('items')
  //       .get();
  //   db.then((value) async {
  //     value.docs.forEach((element) {
  //       element.reference.get().then((value) async {
  //         await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc('${firebaseuser?.uid}')
  //             .collection('myorder')
  //             .add({
  //           "title": "${value.data()!['title']}",
  //           "price": value.data()!['price']
  //         });
  //       });
  //     });
  //   });
  // }

  Widget buildsheet(dynamic snapshot) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Address:   ",
                    style: TextStyle(fontSize: 20, fontFamily: 'poppins'),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "${snapshot.data['address']}",
                      style: TextStyle(fontSize: 16, fontFamily: 'poppins'),
                    ),
                  ),
                ),
              ],
            ),
            CupertinoButton(
              color: Colors.blue,
              child: Text("Change Address"),
              onPressed: () async {
                bool _serviceenabled;
                PermissionStatus _permissionStatus;
                // Future<LocationData> _locationdata;

                _serviceenabled = await Location.instance.serviceEnabled();
                if (!_serviceenabled) {
                  _serviceenabled = await Location.instance.requestService();
                  if (!_serviceenabled) {
                    String err = "Please Enable Location";
                    return showsuccesssnackbar(context, err, Colors.red);
                  }
                }
                _permissionStatus = await Location.instance.hasPermission();
                if (_permissionStatus == PermissionStatus.denied) {
                  _permissionStatus =
                      await Location.instance.requestPermission();
                  if (_permissionStatus != PermissionStatus.granted) {
                    if (_permissionStatus == PermissionStatus.denied) {
                      _permissionStatus =
                          await Location.instance.requestPermission();
                    }
                    _permissionStatus =
                        await Location.instance.requestPermission();
                    String err = "Please Give Permission For Location";
                    return showsuccesssnackbar(context, err, Colors.red);
                  }
                }
                if (_serviceenabled &&
                    _permissionStatus == PermissionStatus.granted) {
                  (Provider.of<GenerateMaps>(context, listen: false)
                          .getcurrentlocation())
                      .whenComplete(() {
                    Provider.of<Changeaddress>(context, listen: false)
                        .cleanadd();
                    return Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Googlemaps();
                    }));
                  });
                }
              },
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Phone no:   ",
                      style: TextStyle(fontSize: 20, fontFamily: 'poppins')),
                ),
                snapshot.data['phoneno'] == 0 ||
                        snapshot.data['phoneno'].toString().length < 10
                    ? CupertinoButton(
                        child: Text("Add Phone Number"),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Phoneno();
                          }));
                        })
                    : Text("${snapshot.data['phoneno']}",
                        style: TextStyle(fontSize: 20, fontFamily: 'poppins')),
              ],
            ),
            CupertinoButton(
                color: Colors.blue,
                child: Text("Change Number"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Phoneno();
                    },
                  ));
                }),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Total Items:   ",
                      style: TextStyle(fontSize: 20, fontFamily: 'poppins')),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc('${firebaseuser?.uid}')
                      .collection('items')
                      .where("quantity", isGreaterThan: 0)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('no data'));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Text("${snapshot.data.docs.length}",
                        style: TextStyle(fontSize: 20, fontFamily: 'poppins'));
                  },
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Total:   ",
                      style: TextStyle(fontSize: 20, fontFamily: 'poppins')),
                ),
                Text("${snapshot.data['total']}" + " rs",
                    style: TextStyle(fontSize: 20, fontFamily: 'poppins')),
              ],
            ),
            CupertinoButton(
                color: Colors.orange,
                child: Text("💳 " + "Online Payment"),
                onPressed: () {
                  if (snapshot.data['phoneno'] == 0) {
                    Navigator.pop(context);
                    String err = "Add Phone number";
                    showsuccesssnackbar(context, err, Colors.red);
                  } else if (snapshot.data['address'] == "" ||
                      snapshot.data['address'] == null) {
                    Navigator.pop(context);
                    String err = "Add Address";
                    showsuccesssnackbar(context, err, Colors.red);
                  } else {
                    gotopayment(snapshot.data['phoneno']);
                  }
                }),
            CupertinoButton(
                color: Colors.orange,
                child: Text("💵 " + "Cash Payment"),
                onPressed: () {
                  if (snapshot.data['phoneno'] == 0) {
                    Navigator.pop(context);
                    String err = "Add Phone number";
                    showsuccesssnackbar(context, err, Colors.red);
                  } else if (snapshot.data['address'] == "" ||
                      snapshot.data['address'] == null) {
                    Navigator.pop(context);
                    String err = "Add Address";
                    showsuccesssnackbar(context, err, Colors.red);
                  } else {
                    _showdialog(context, snapshot);
                  }
                })
          ],
        ),
      );

  _showdialog(BuildContext context, dynamic snapshot) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("Cash Payment"),
              content: Text("Accept For Cash Payment"),
              actions: [
                CupertinoDialogAction(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context);
                    _onPressed("Cash,Pending");
                  },
                )
              ],
            ));
  }

  void _onPressed(String pay) async {
    var _orderid;
    num? _items;
    num? _total;
    String? _address;
    String? _phoneno;
    num? _lat;
    num? _log;
    await FirebaseFirestore.instance
        .collection("users")
        .doc('${firebaseuser?.uid}')
        .collection('total')
        .doc('total-123')
        .get()
        .then((value) {
      _orderid = value.data()!['orderid'] + 1;
      _total = value.data()!['total'];
      _address = value.data()!['address'];
      _lat = value.data()!['lat'];
      _log = value.data()!['log'];
      _phoneno = value.data()!['phoneno'];
      print(_orderid);
    }).whenComplete(() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc('${firebaseuser?.uid}')
          .collection('items')
          .where("quantity", isGreaterThan: 0)
          .get()
          .then((querySnapshot) {
        _items = querySnapshot.docs.length;
        querySnapshot.docs.forEach((result) async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseuser?.uid)
              .collection("myorder")
              .doc("$_orderid")
              .collection("subcoll")
              .add({
            "title": result.data()['title'],
            "bcimage": result.data()['bcimage'],
            "price": result.data()['price'],
            "quantity": result.data()['quantity'],
            "id": result.data()['id'],
            "weight": result.data()['weight'],
            "stock": result.data()['stock'],
            "status": result.data()['status']
          }).whenComplete(() async {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(firebaseuser?.uid)
                .collection("myorder")
                .doc("$_orderid")
                .set({
              "items": _items,
              "orderid": _orderid,
              "total": _total,
              "date": "${DateTime.now().day}-" +
                  "${DateTime.now().month}-" +
                  "${DateTime.now().year}",
              "address": _address,
              "status": "Order Placed",
              "approved": false,
              "phoneno": _phoneno
            });
          }).whenComplete(() async {
            await FirebaseFirestore.instance
                .collection('order')
                .doc('${firebaseuser?.uid}')
                .set({"approved": false, "email": "${firebaseuser?.email}"});
          }).whenComplete(() async {
            await FirebaseFirestore.instance
                .collection('order')
                .doc('${firebaseuser?.uid}')
                .collection('pendingorder')
                .doc('$_orderid')
                .set({
              "Payment": pay,
              "items": _items,
              "orderid": _orderid,
              "total": _total,
              "date": "${DateTime.now().day}-" +
                  "${DateTime.now().month}-" +
                  "${DateTime.now().year}",
              "address": _address,
              "status": "Order Placed",
              "approved": false,
              "email": "${firebaseuser?.email}",
              "uid": "${firebaseuser?.uid}",
              "lat": _lat,
              "log": _log,
              "phoneno": _phoneno
            }).whenComplete(() async {
              await FirebaseFirestore.instance
                  .collection('order')
                  .doc('${firebaseuser?.uid}')
                  .collection('pendingorder')
                  .doc('$_orderid')
                  .collection('subcoll')
                  .add({
                "title": result.data()['title'],
                "bcimage": result.data()['bcimage'],
                "price": result.data()['price'],
                "quantity": result.data()['quantity'],
                "id": result.data()['id'],
                "weight": result.data()['weight'],
                "stock": result.data()['stock'],
                "status": result.data()['status']
              });
            });
          });
        });
      });
    }).whenComplete(() {
      var db = FirebaseFirestore.instance
          .collection('users')
          .doc('${firebaseuser?.uid}')
          .collection('items')
          .get();
      db.then((value) async {
        value.docs.forEach((element) {
          element.reference.delete();
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${firebaseuser?.uid}')
            .collection('total')
            .doc('total-123')
            .update({"total": 0});
      });
    }).whenComplete(() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc('${firebaseuser?.uid}')
          .collection('total')
          .doc('total-123')
          .update({"orderid": _orderid});
    }).whenComplete(() {
      showsuccesssnackbar(context, "Success", Colors.blue);
    });
  }

  void showsuccesssnackbar(BuildContext context, err, colorname) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            size: 32,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Text(
            '$err',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ))
        ],
      ),
      backgroundColor: colorname,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 15,
    );

    ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    ScaffoldMessenger.of(context)..showSnackBar(snackBar);
  }
}
