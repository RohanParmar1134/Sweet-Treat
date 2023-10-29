import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googlesignin = GoogleSignIn();
  String? useruid;
  String? get getuseruid => useruid;
  String? userimage;
  String? get getuserimage => userimage;
  String? username;
  String? get getusername => username;
  String? useremail;
  String? get getuseremail => useremail;

  Future signinwithgoogle(BuildContext context) async {
    final GoogleSignInAccount? googleSignInAccount =
        await googlesignin.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final userCredential = await firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication?.idToken,
            accessToken: googleSignInAuthentication?.accessToken));

    final User? user = userCredential.user;
    final _null = null;
    assert(user?.uid != null);
    // if (firebaseAuth.currentUser == null) {
    //   print('i am in print function');
    //   Navigator.pushAndRemoveUntil(context,
    //       MaterialPageRoute(builder: (context) => Signup()), (route) => false);
    // }

    if (userCredential != _null) {
      userimage = user?.photoURL;
      username = user?.displayName;
      useruid = user?.uid;
      useremail = user?.email;
      print(
          ' name => $username, email => $useremail, uid => $useruid, image => $userimage');
      notifyListeners();
    } else {
      String failed = 'FAILED TO LOGIN';
      showerrorsnackbar(context, failed);
    }
  }

  Future signoutwithgoogle() async {
    print(' name => $username, email => $useremail, uid => $useruid');
    await googlesignin.signOut();

    username = null;
    useremail = null;
    useruid = null;
    print(' name => $username, email => $useremail, uid => $useruid');
    notifyListeners();
  }

  void showerrorsnackbar(BuildContext context, err) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            size: 32,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Text(
            '$err',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ))
        ],
      ),
      backgroundColor: Colors.red,
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
