import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/admin/additem.dart';
import 'package:online_bakery_shop/admin/adminscreen.dart';
import 'package:online_bakery_shop/provider/paymentprovider.dart';
import 'package:online_bakery_shop/provider/checkAUM.dart';
import 'package:online_bakery_shop/provider/counter.dart';
import 'package:online_bakery_shop/provider/homedrawerprovider.dart';
import 'package:online_bakery_shop/provider/maps.dart';
import 'package:online_bakery_shop/provider/permission_handler.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/Authentification.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/forcolor.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/google_maps.dart';
import 'package:online_bakery_shop/screen/all_auth/authservice/services/googleauth.dart';
import 'package:online_bakery_shop/screen/all_main_screen/allcategories.dart';
import 'package:online_bakery_shop/screen/all_main_screen/bottomnavbar.dart';
import 'package:online_bakery_shop/screen/all_main_screen/cart.dart';
import 'package:online_bakery_shop/screen/all_main_screen/mainhomescreen.dart';
import 'package:online_bakery_shop/screen/all_main_screen/myorder.dart';
import 'package:online_bakery_shop/testingscreen/providertesting.dart';
import 'package:online_bakery_shop/testingscreen/testing.dart';
import 'package:online_bakery_shop/testingscreen/testing2.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/passwordreset.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signin.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/signup.dart';
import 'package:online_bakery_shop/screen/all_auth/authscreen/splash.dart';
import 'package:online_bakery_shop/screen/all_main_screen/homepage.dart';
import 'package:online_bakery_shop/screen/all_main_screen/welcome.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance
      .activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // StreamProvider.value(
        //     value: FirebaseAuth.instance.authStateChanges(), initialData: null),
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider.value(value: Counter()),
        ChangeNotifierProvider.value(value: CheckADM()),
        ChangeNotifierProvider.value(value: Homedrawerprovider()),
        ChangeNotifierProvider.value(value: Itemcount()),
        ChangeNotifierProvider.value(value: Paymentprovider()),
        ChangeNotifierProvider.value(value: GenerateMaps()),
        ChangeNotifierProvider.value(value: Getpermission()),
        ChangeNotifierProvider.value(value: Changeaddress())
        // ChangeNotifierProvider.value(value: Fetchcartdata())
        // ChangeNotifierProvider<Homecat>(create: (context) => Homecat())
        // ChangeNotifierProvider(create: (_) => Managedata()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(color: rprimarycolor),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          "/Gauth": (context) => Gauth(),
          "/preset": (context) => Preset(),
          "/testing": (context) => Datafav(),
          "/testing2": (context) => Testing2(),
          "/cart": (context) => Cart(),
          // "/testing3": (context) => Testing3(),
          "/bottombarpage": (context) => Bottombarpage(),
          "/": (context) => Splashscreen(),
          "/allcategories": (context) => Allcategories(),
          "/pt": (context) => Providertesting(),
          "/mainhomescreen": (context) => Mainhomescreen(),
          "/admin": (context) => Adminscreen(),

          // "/detailscreen": (context) => Detailscreen(),
          "/homepage": (context) => Homepage(),
          "/signup": (context) => Signup(),
          "/welcome": (context) => Welcome(),
          "/signin": (context) => Signin(),
        },
      ),
    );
  }
}
