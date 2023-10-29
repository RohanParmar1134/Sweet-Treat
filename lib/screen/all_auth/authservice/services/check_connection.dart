// import 'package:flutter/material.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:overlay_support/overlay_support.dart';

// class Checkconnection extends StatefulWidget {
//   @override
//   _CheckconnectionState createState() => _CheckconnectionState();
// }

// class _CheckconnectionState extends State<Checkconnection> {
//   bool hasinternet = false;

//   bool hasconnection = false;
//   @override
//   void initState() {
//     check();
//     final text = hasconnection ? 'internet' : 'no internet';
//     setState(() => this.hasinternet = hasinternet);
//     if (hasconnection == true) {
//       Navigator.pop(context);
//       showSimpleNotification(Text('$text'));
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Lottie.asset(
//               'assets/gif/forverify/9010-no-connection-animation.json'),
//           SizedBox(
//             height: 50,
//           ),
//           Text(
//             'please check internet connection',
//             style: TextStyle(fontSize: 20),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Future check() async {
//   bool hasconnection = false;
//   bool hasinternet = false;
//   print('i am in init state of check connection');
//   hasconnection = await InternetConnectionChecker().hasConnection;
//   InternetConnectionChecker().onStatusChange.listen((status) {
//     final hasinternet = status == InternetConnectionStatus.connected;
//   });
// }
