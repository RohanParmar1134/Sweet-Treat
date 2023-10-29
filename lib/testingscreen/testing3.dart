// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';

// class Testing3 extends StatelessWidget {
//   const Testing3({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           color: Colors.blueGrey,
//           height: 200,
//           width: 200,
//           child: Column(
//             children: [check()],
//           ),
//           // child: StreamBuilder(
//           //     stream: FirebaseFirestore.instance
//           //         .collection('cart')
//           //         .doc('8jXFSBRfFWas2yFLmaMbspviqt93')
//           //         .collection('items')
//           //         .doc('bread-id123')
//           //         .snapshots(),
//           //     builder: (BuildContext context, AsyncSnapshot snapshot) {
//           //       if (snapshot.connectionState == ConnectionState.waiting) {
//           //         return Center(
//           //           child: CircularProgressIndicator(),
//           //         );
//           //       } else {
//           //         var userdoc = snapshot.data;
//           //         return Container(child: Text('${userdoc['title']}'));
//           //       }
//           //     }),
//         ),
//       ),
//     );
//   }
// }

// Widget check() {
//   return Container(
//       // child: StreamBuilder(
//       //   stream: ,
//       //   builder: (BuildContext context, AsyncSnapshot snapshot) {
//       //     return Container(
//       //       child: Column(
//       //         children: [
//       //           IconButton(onPressed: () {}, icon: Icon(EvaIcons.minus)),
//       //           Text('${snapshot.data}'),
//       //           IconButton(onPressed: () {}, icon: Icon(EvaIcons.plus))
//       //         ],
//       //       ),
//       //     );
//       //   },
//       // ),
//       );
// }
