// import 'package:flutter/material.dart';

// typedef void CountButtonClickCallBack(int count);

// class CountButtonView extends StatefulWidget {
//   final int initialCount;
//   final CountButtonClickCallBack onChange;
//   CountButtonView({required this.initialCount, required this.onChange});
//   @override
//   _CountButtonViewState createState() => _CountButtonViewState();
// }

// class _CountButtonViewState extends State<CountButtonView> {
//   int? count;
//   @override
//   void initState() {
//     super.initState();
//     count = widget.initialCount;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void updateCount(int addValue) {
//     if (count! + addValue >= 0) {
//       setState(() {
//         count! =  count! + addValue;
//       });
//      final _nu =null;
//       if (widget.onChange != _nu) {
//         widget.onChange(count!);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 110.0,
//       height: 44.0,
//       child: Center(
//         child: Container(
//           decoration: BoxDecoration(
//               color: Color(0xddFFFFFF),
//               border: Border.all(color: Colors.orange, width: 1.0),
//               borderRadius: BorderRadius.circular(22.0)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               GestureDetector(
//                   onTap: () {
//                     updateCount(-1);
//                   },
//                   child: Container(
//                       width: 40.0,
//                       child: Center(
//                           child: Text(
//                         '-',
//                         style: TextStyle(
//                             fontSize: 25.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.orange,
//                             decoration: TextDecoration.none),
//                       )))),
//               Container(
//                 child: Center(
//                     child: Text(
//                   '$count',
//                   style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.orange,
//                       decoration: TextDecoration.none),
//                 )),
//               ),
//               GestureDetector(
//                   onTap: () {
//                     updateCount(1);
//                   },
//                   child: Container(
//                       width: 40.0,
//                       child: Center(
//                           child: Text(
//                         '+',
//                         style: TextStyle(
//                             fontSize: 25.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.orange,
//                             decoration: TextDecoration.none),
//                       )))),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
