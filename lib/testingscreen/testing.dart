import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> third method <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

class Datafav extends StatefulWidget {
  const Datafav({Key? key}) : super(key: key);

  @override
  _DatafavState createState() => _DatafavState();
}

class _DatafavState extends State<Datafav> {
  Map? data;
  fetchdata() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('categories');
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.docs[0].data() as Map;
      });
    });
  }

  String? imageurl;
  File? image;
  String? urlimage;
  pickimage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    try {
      // ignore: invalid_use_of_visible_for_testing_member
      image = (await ImagePicker.platform
          .pickImage(source: ImageSource.gallery)) as File?;
    } catch (e) {
      print(e);
    }
  }

  // FirebaseStorage fs;

  sendimage() async {
    print('loading');
    // ignore: unused_local_variable
    var storageimage = FirebaseStorage.instance.ref().child(image!.path);
    print('take image');
    // ignore: unused_local_variable
    Future<TaskSnapshot> task =
        FirebaseStorage.instance.ref().child(image!.path).putFile(image!);
    //     .whenComplete(() async {
    //   print('in loading');
    //   urlimage = await storageimage.getDownloadURL();
    //   print(urlimage);
    // });
  }

  printUrl(BuildContext context) async {
    Reference ref = FirebaseStorage.instance.ref().child("IMG_0098.JPG");
    imageurl = (await ref.getDownloadURL()).toString();
    print(imageurl);

    return Container(
      height: 200,
      width: 200,
      child: Image.network(
        '$imageurl',
        fit: BoxFit.scaleDown,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var collection = FirebaseFirestore.instance.collection('usera');
    // var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                // print('${user?.uid}');
                // var firebaseuser = FirebaseAuth.instance.currentUser;
                FirebaseFirestore firebaseFirestore =
                    FirebaseFirestore.instance;
                firebaseFirestore
                    .collection('categories')
                    .doc('2iKcUKJVnjcHZoXFp7y4')
                    .update({
                  "name": "rohan",
                  "age": 17,
                }).whenComplete(() {
                  print('sucess');
                });
              },
              child: Text('add data with uid')),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                fetchdata();
              },
              child: Text('fetch data')),
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.yellow,
            // child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            //   future: collection.doc('${user?.uid}').get(),
            //   builder: (_, snapshot) {
            //     if (snapshot.hasError)
            //       return Text('Error = ${snapshot.error}');

            //     if (snapshot.hasData) {
            //       var output = snapshot.data!.data();
            //       // var value = output; // example@gmail.com
            //       return Text('$output');
            //     }

            //     return Center(child: CircularProgressIndicator());
            //   },
            // )
            child: Text(data.toString()),
          ),
          ElevatedButton(
              onPressed: () {
                sendimage();
                // printUrl(context);
                // getFirebaseImageFolder();
              },
              child: Text('fetch image')),
          InkWell(
            onTap: pickimage,
            child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 100,
                backgroundImage: image != null ? FileImage(image!) : null),
          )
        ],
      ),
    );
  }
}
