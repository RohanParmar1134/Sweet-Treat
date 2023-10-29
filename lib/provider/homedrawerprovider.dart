import 'package:flutter/material.dart';

class Homedrawerprovider extends ChangeNotifier {
  double? xoffset = 0;
  double? get getxoffset => xoffset;
  double? yoffset = 0;
  double? get getyoffset => yoffset;
  double? scalefactor = 1;
  double? get getscalefactor => scalefactor;
  bool drawerstatus = false;
  bool get getdrawerstatus => drawerstatus;

  void opendrawer() {
    xoffset = 230;
    yoffset = 170;
    scalefactor = 0.6;
    drawerstatus = true;
    print(xoffset);

    notifyListeners();
  }

  void closedrawer() {
    xoffset = 0;
    yoffset = 0;
    scalefactor = 1;
    drawerstatus = false;

    notifyListeners();
  }
}
