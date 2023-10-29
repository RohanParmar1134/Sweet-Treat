import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/admin/additem.dart';
import 'package:online_bakery_shop/admin/edititem.dart';
import 'package:online_bakery_shop/admin/deliverpending.dart';
import 'package:online_bakery_shop/admin/editrecomended.dart';
import 'package:online_bakery_shop/admin/pendingorder.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/Authentification.dart';
import 'package:online_bakery_shop/testingscreen/testing2.dart';
import 'package:provider/provider.dart';

class Adminscreen extends StatelessWidget {
  const Adminscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? users = _auth.currentUser;
    String? useremail = _auth.currentUser?.email;
    String? username = _auth.currentUser?.displayName;
    String? userphotourl = _auth.currentUser?.photoURL;
    String logoutsucess = 'Logout Sucessfully';
    //
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text('admin page'),
        actions: [
          IconButton(
              onPressed: () async {
                if (_auth.currentUser?.providerData[0].providerId ==
                    'google.com') {
                  print(
                      'before user data ====> $useremail,$userphotourl,$username');

                  useremail = null;
                  userphotourl = null;
                  username = null;
                  await _auth.signOut();
                  print(
                      'after user data ====> $useremail,$userphotourl,$username');
                  await Provider.of<Authentication>(context, listen: false)
                      .signoutwithgoogle()
                      .whenComplete(() {
                    users = null;

                    return Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Signin()),
                        (route) => false);
                  });
                } else {
                  await _auth.signOut();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Signin()),
                      (route) => false);
                }
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          // child: ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  _container("Pending Orders", Pendingorder(), context),
                  _container("Deliver-Pending", Dpending(), context),
                ],
              ),
              Column(
                children: [
                  _container("Edit Items", AdminAllcategories(), context),
                  _container("Add Items", Testing2(), context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _container(String headingname, gotopagename, context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.amber,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return gotopagename;
          }));
        },
        child: Container(
          height: 200,
          width: 180,
          child: Center(
              child: Text(
            headingname,
            style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )),
        ),
      ),
    );
  }
}
