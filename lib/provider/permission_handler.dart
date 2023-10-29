import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

class Getpermission extends ChangeNotifier {
  forpermission() async {
    // if (Platform.isAndroid) {
    //   LocationPermission checkpermission = await Geolocator.checkPermission();
    //   // var locationpermission = await Permission.locationAlways.status;
    //   if (checkpermission == LocationPermission.denied) {
    //     Geolocator.requestPermission();
    //     print(checkpermission);
    //   } else {
    //     // return locationpermission.toString();
    //     print(checkpermission);
    //   }
    // }

    bool _serviceenabled;
    PermissionStatus _permissionStatus;
    // Future<LocationData> _locationdata;

    _serviceenabled = await Location.instance.serviceEnabled();
    if (!_serviceenabled) {
      _serviceenabled = await Location.instance.requestService();
      if (!_serviceenabled) {
        return;
      }
    }

    _permissionStatus = await Location.instance.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await Location.instance.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    notifyListeners();
  }

  // checkpermission() {
  //   Permission.locationAlways.status;
  // }
}
