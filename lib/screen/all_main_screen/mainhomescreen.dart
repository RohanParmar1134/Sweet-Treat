import 'package:flutter/material.dart';
import 'package:online_bakery_shop/screen/all_main_screen/drawerscreen.dart';
import 'package:online_bakery_shop/screen/all_main_screen/homepage.dart';

class Mainhomescreen extends StatelessWidget {
  const Mainhomescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Drawerscreen(),
          Homepage(),
        ],
      ),
    );
  }
}
