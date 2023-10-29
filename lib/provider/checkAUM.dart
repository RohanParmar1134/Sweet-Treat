import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckADM extends ChangeNotifier {
  String? adm;
  // ignore: non_constant_identifier_names
  String? ADM;
  getADM() async {
    String? userquery = await FirebaseFirestore.instance
        .collection('admin')
        .where("email", isEqualTo: "rohanparmar1162@gmail.com")
        .get()
        .then((QuerySnapshot _querySnapshot) {
      adm = (_querySnapshot.docs[0]['email']);
      print(adm);
      return adm;
    });

    notifyListeners();
  }

  String? get getadm {
    return adm;
  }
}
