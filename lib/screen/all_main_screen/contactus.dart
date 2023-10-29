import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactus extends StatelessWidget {
  const Contactus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email: ",
                  style: TextStyle(fontSize: 20, fontFamily: "poppins"),
                ),
                TextButton(
                    onPressed: () {
                      launch("mailto:rohanparmar1162@gmail.com");
                    },
                    child: Text("rohanparmar1162@gmail.com",
                        style: TextStyle(fontSize: 14, fontFamily: "poppins")))
              ],
            ),
          ),
          Center(
              child: Text("Thank you for your Feedback❤️",
                  style: TextStyle(fontSize: 20, fontFamily: "poppins")))
        ],
      ),
    );
  }
}
