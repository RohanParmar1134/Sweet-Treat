// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';

// class Testing2 extends StatefulWidget {
//   const Testing2({Key? key}) : super(key: key);

//   @override
//   _Testing2State createState() => _Testing2State();
// }

// class _Testing2State extends State<Testing2> {
//   // String? filelocation;

//   @override
//   Widget build(BuildContext context) {
//     final filename = file != null ? basename(file!.path) : 'no image';

//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         // crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // backgroundImage: FileImage(image! as File)
//           Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       getimage();
//                     },
//                     child: Text('getimage')),
//                 Text(
//                   filename,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       uploadfile(filename);
//                     },
//                     child: Text('upload file')),
//                 // TextButton(
//                 //     onPressed: () {
//                 //       geturl(filename);
//                 //     },
//                 //     child: Text('get url')),
//                 Container(
//                     height: 300,
//                     width: 300,
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       image: DecorationImage(
//                           image:
//                               NetworkImage(data == null ? 'waiting' : '$data')),
//                     ))
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   File? file;
//   String? fileurl;
//   String? data;

//   Future getimage() async {
//     final image = await FilePicker.platform.pickFiles(allowMultiple: false);

//     if (image == null) return;
//     final path = image.files.single.path;
//     setState(() {
//       file = File(path!);
//     });
//   }

//   uploadfile(filename) {
//     try {
//       final ref = FirebaseStorage.instance.ref('allcategories/$filename');
//       return ref
//           .putFile(file!)
//           .whenComplete(() => geturl(filename))
//           .whenComplete(() => urltofirestore())
//           .whenComplete(() => print('>>>>>>> complete <<<<<<'));
//     } on FirebaseException catch (e) {
//       print(e);
//     }
//   }

//   geturl(filename) async {
//     fileurl = await FirebaseStorage.instance
//         .ref('allcategories/$filename')
//         .getDownloadURL();

//     print(fileurl);
//   }

//   urltofirestore() {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     firebaseFirestore
//         .collection('allcategories')
//         .doc('bread-id123')
//         .collection('bread')
//         .doc('bread-id123')
//         .update({'bcimage': '$fileurl'}).whenComplete(() {
//       print('sucess');
//     });
//   }

//   // fetchdata() {
//   //   CollectionReference collectionReference =
//   //       FirebaseFirestore.instance.collection('pizza');
//   //   collectionReference.snapshots().listen((snapshot) {
//   //     setState(() {
//   //       data = snapshot.docs[0]['pizza'].toString();
//   //       print(data);
//   //     });
//   //   });
//   //   return data;
//   // }
// }
