import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/provider/homedrawerprovider.dart';
import 'package:online_bakery_shop/screen/all_main_screen/account.dart';
import 'package:online_bakery_shop/screen/all_main_screen/allcategories.dart';
import 'package:online_bakery_shop/screen/all_main_screen/cart.dart';
import 'package:online_bakery_shop/screen/all_main_screen/mainhomescreen.dart';
import 'package:provider/provider.dart';

class Bottombarpage extends StatefulWidget {
  const Bottombarpage({Key? key}) : super(key: key);

  @override
  State<Bottombarpage> createState() => _BottombarpageState();
}

int? _index = 0;
final navigationkey = GlobalKey<CurvedNavigationBarState>();
final screen = <Widget>[Mainhomescreen(), Allcategories(), Account(), Cart()];

class _BottombarpageState extends State<Bottombarpage> {
  @override
  Widget build(BuildContext context) {
    var drawerstatus = Provider.of<Homedrawerprovider>(context).getdrawerstatus;
    final bgcolorlist = <Color>[
      drawerstatus == true ? Color(0xFFC58140) : Colors.white,
      Colors.amber,
      Colors.white,
      Colors.orange[800]!,
    ];
    final colorlist = <Color>[
      drawerstatus == true ? Colors.white : Colors.orange,
      Colors.white,
      Colors.orange,
      Colors.white,
    ];

    return Scaffold(
        body: screen[_index!],
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: bgcolorlist[_index!],
            color: colorlist[_index!],
            index: _index!,
            height: 60,
            onTap: (index) => setState(() => _index = index),
            animationDuration: Duration(milliseconds: 400),
            items: [
              Icon(Icons.home),
              Icon(CupertinoIcons.decrease_indent),
              Icon(CupertinoIcons.profile_circled),
              Icon(CupertinoIcons.cart),
            ]));
  }
}
