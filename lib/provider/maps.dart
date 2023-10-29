import 'package:flutter/cupertino.dart';
import 'package:flutter_geocoder/geocoder.dart';
// import 'package:flutter_geocoder/geocoder.dart';
// import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// GeoCode geoCode = GeoCode();

class GenerateMaps extends ChangeNotifier {
  Position? finaladdress;
  Position? get getfinaladdress => finaladdress;
  String? putaddress;
  String? get getputaddress => putaddress;
  Position? position;
  double lat = 0;
  double? get getlat => lat;
  double lon = 0;
  double? get getlon => lon;

  // Set<Marker> _marker = {};

  GoogleMapController? googleMapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future getcurrentlocation() async {
    var positiondata = await GeolocatorPlatform.instance.getCurrentPosition();
    // Future<Address> coordinates = geoCode.reverseGeocoding(
    //     latitude: positiondata.latitude, longitude: positiondata.longitude);
    // print(coordinates);
    final cords = Coordinates(positiondata.latitude, positiondata.longitude);
    var address = await Geocoder.local.findAddressesFromCoordinates(cords);
    String? mainaddress = address.first.addressLine;
    print(mainaddress);
    putaddress = mainaddress;
    finaladdress = positiondata;
    lat = positiondata.latitude;
    lon = positiondata.longitude;
    notifyListeners();
  }

  getlet() {
    return finaladdress;
  }

  getmarker(double lat, double lng) {
    MarkerId markerId = MarkerId(lat.toString() + lng.toString());
    Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: "my title", snippet: "country name"));
    markers[markerId] = marker;
    notifyListeners();
  }

  // Widget fetchmap() {
  //   List _marker = [];

  //   return
  // }

  getadd() {
    return putaddress;
  }
}
