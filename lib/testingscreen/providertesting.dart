import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/provider/counter.dart';
import 'package:provider/provider.dart';

class Providertesting extends StatelessWidget {
  const Providertesting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int cartcount = Provider.of<Counter>(context).getcounter;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Provider.of<Counter>(context, listen: false).decrement();
                  },
                  icon: Icon(EvaIcons.minus)),
              Text('$cartcount'),
              IconButton(
                  onPressed: () {
                    Provider.of<Counter>(context, listen: false).increment();
                  },
                  icon: Icon(EvaIcons.plus)),
            ],
          )
        ],
      ),
    );
  }
}
