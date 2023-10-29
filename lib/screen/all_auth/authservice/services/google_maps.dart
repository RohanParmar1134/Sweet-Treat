import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
// import 'package:flutter_geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:online_bakery_shop/provider/maps.dart';
import 'package:provider/provider.dart';

class Googlemaps extends StatefulWidget {
  const Googlemaps({Key? key}) : super(key: key);

  @override
  State<Googlemaps> createState() => _GooglemapsState();
}

User? firebaseAuthuser = FirebaseAuth.instance.currentUser;
String manualaddress = '';
String? autoaddress = '';
var addressfromcord;
var cord;
var cords;
double? lat;
double? log;

class _GooglemapsState extends State<Googlemaps> {
  GoogleMapController? googleMapController;
  List _marker = [];
  TextEditingController addctrl = TextEditingController();
  final _formkey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // setState(() {});
    autoaddress = autoaddress == null
        ? Provider.of<GenerateMaps>(context, listen: false).putaddress
        : Provider.of<Changeaddress>(context, listen: false).getfinaladd;
    lat = Provider.of<GenerateMaps>(context, listen: false).getlat;
    log = Provider.of<GenerateMaps>(context, listen: false).getlon;
    return Scaffold(
      body: Stack(children: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapToolbarEnabled: true,
              buildingsEnabled: true,
              compassEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      Provider.of<GenerateMaps>(context, listen: false).lat,
                      Provider.of<GenerateMaps>(context, listen: false).lon),
                  zoom: 18),
              onMapCreated: (GoogleMapController mapcontroller) {
                googleMapController = mapcontroller;
                mapcontroller.setMapStyle(Utils.mapstyle);
              },
              markers: Set.from(_marker),
              onTap: _handleTap,
            )),
        Positioned(
            top: 80,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 50,
              // width: 300,
              child: Center(
                  child: Text(
                "$autoaddress",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                    color: Colors.brown),
              )),
            )),
        Positioned(
            bottom: 115,
            left: 50,
            right: 50,
            child: InkWell(
              onTap: () {
                print("hello");
                savepointeraddtofirebase();
                String err = "Address Saved.";
                showsuccesssnackbar(context, err);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 50,
                // width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Save This Address",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                          color: Colors.brown),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.pin_drop_outlined,
                      size: 30,
                      color: Colors.brown,
                    ),
                  ],
                ),
              ),
            )),
        Positioned(
          bottom: 50,
          right: 50,
          left: 50,
          child: InkWell(
            onTap: () async {
              print("hello");
              return showModalBottomSheet(
                  context: context, builder: (context) => buildsheet());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 50,
              // width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add Address Manually",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                        color: Colors.brown),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Icon(
                      CupertinoIcons.pencil_ellipsis_rectangle,
                      size: 30,
                      color: Colors.brown,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  _handleTap(LatLng point) async {
    _marker = [];

    // print(point);
    // print(_marker);
    setState(() {
      _marker.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        // infoWindow: InfoWindow(title: 'Your Delivery Place'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
      // print(_marker);
      print(point);

      cord = Coordinates(point.latitude, point.longitude);
    });
    cords = cord;
    print(cord + "[[[[[[[[[[[[[[[[[[[[[");
    addressfromcord = await Geocoder.local.findAddressesFromCoordinates(cord);
    Provider.of<Changeaddress>(context, listen: false).getnewadd();
    // var addressfromcord =
    //     await Geocoder.local.findAddressesFromCoordinates(cord);
    // String? mainaddress = addressfromcord.first.addressLine;
    // setState(() {
    //   autoaddress = mainaddress;
    // });
    // print(autoaddress);
  }

  Widget buildsheet() => Container(
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey1,
            child: Column(
              children: [
                TextFormField(
                  controller: addctrl,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "House-no, society/Flat Name, Area Name",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Address";
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      manualaddress = value;
                    });
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (_formkey1.currentState!.validate()) {
                        setState(() {});
                        savemanualaddtofirebase();
                        // return _signin(_email, _password);
                      } else {
                        setState(() {});
                        return null;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 50,
                      width: 300,
                      child: Center(
                          child: Text(
                        "Save Address",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'poppins',
                            color: Colors.brown),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  // printadd() async {}
  savemanualaddtofirebase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${firebaseAuthuser?.uid}')
        .collection('total')
        .doc('total-123')
        .update({'address': '$manualaddress'}).whenComplete(() {
      print("successful add address");
      Navigator.pop(context);
      String err = "Address Saved.";
      showsuccesssnackbar(context, err);
    });
  }

  savepointeraddtofirebase() async {
    print(autoaddress);
    print(cord);
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${firebaseAuthuser?.uid}')
        .collection('total')
        .doc('total-123')
        .update({
      'address': '$autoaddress',
      "lat": lat,
      "log": log,
    }).whenComplete(() => print("successful add address"));
  }

  void showsuccesssnackbar(BuildContext context, err) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.done_outline_rounded,
            color: Colors.brown[900],
            size: 35,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Text(
            '$err',
            style: TextStyle(
              fontSize: 20,
              color: Colors.brown[900],
              fontWeight: FontWeight.bold,
              fontFamily: 'poppins',
            ),
          ))
        ],
      ),
      backgroundColor: Colors.orange[100],
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 15,
    );

    ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    ScaffoldMessenger.of(context)..showSnackBar(snackBar);
  }
}

class Changeaddress extends ChangeNotifier {
  // get getautoaddress => autoaddress;
  String? finaladd;
  String? get getfinaladd => finaladd;
  getnewadd() async {
    autoaddress = addressfromcord.first.addressLine;
    finaladd = autoaddress;
    cords = cord;
    notifyListeners();
    print(autoaddress);
  }

  // newadstring() {

  //   notifyListeners();
  // }

  cleanadd() {
    autoaddress = null;
    notifyListeners();
  }
}

//! map style json code

class Utils {
  static String mapstyle = '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#523735"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#c9b2a6"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#dcd2be"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ae9e90"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#93817c"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a5b076"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#447530"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#fdfcf8"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f8c967"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#e9bc62"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e98d58"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#db8555"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#806b63"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8f7d77"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b9d3c2"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#92998d"
      }
    ]
  }
]
  ''';

  static String mapstyle2 = '''
  [
  {
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "landscape",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
  ''';
}
