import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';

import 'package:online_bakery_shop/screen/all_main_screen/welcome.dart';
import 'package:provider/provider.dart';

class Gauth extends StatelessWidget {
  const Gauth({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    User? guser = Provider.of<User?>(context);
    final nulll = null;
    guser?.refreshToken;

    if (guser == nulll) {
      return Signin();
    }
    return Welcome();
  }
}
