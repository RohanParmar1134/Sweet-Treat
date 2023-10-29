import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:online_bakery_shop/screen/all_main_screen/cart.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart';

class Testing2 extends StatefulWidget {
  const Testing2({Key? key}) : super(key: key);

  @override
  _Testing2State createState() => _Testing2State();
}

final _formkey = GlobalKey<FormState>();
TextEditingController titlectrl = TextEditingController();
TextEditingController pricectrl = TextEditingController();
TextEditingController weightctrl = TextEditingController();

class _Testing2State extends State<Testing2> {
  // String? filelocation;
  String? valuechoose;
  String? title;
  String? price;
  String? bcimage;
  String? weight;
  @override
  Widget build(BuildContext context) {
    final filename = file != null ? basename(file!.path) : 'no image';

    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Items"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      // backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // backgroundImage: FileImage(image! as File)
              Container(
                // color: Colors.amber,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        getimage();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.folder_circle_fill,
                              size: 50,
                              color: Colors.blue,
                            ),
                            Text(
                              "Pick Image",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      filename,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      hint: Text("Select Categories"),
                      value: valuechoose,
                      items: const [
                        DropdownMenuItem(
                          child: Text("Bread"),
                          value: "bread",
                        ),
                        DropdownMenuItem(
                          child: Text("Cookie"),
                          value: "cookie",
                        ),
                        DropdownMenuItem(
                          child: Text("Bun"),
                          value: "bun",
                        ),
                        DropdownMenuItem(
                          child: Text("Cake"),
                          value: "cake",
                        ),
                        DropdownMenuItem(
                          child: Text("Pizzabase"),
                          value: "pizzabase",
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          valuechoose = value as String;
                          print(valuechoose);
                        });
                      },
                    ),
                    TextFormField(
                      controller: titlectrl,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: "Add Title, Use UnderScore _ (No space)",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Title";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                    ),
                    TextFormField(
                      controller: pricectrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: "Add Price",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Price";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          price = value;
                        });
                      },
                    ),
                    TextFormField(
                      controller: weightctrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: "Add Weight In Gram",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Weight";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          weight = value + "gm";
                        });
                      },
                    ),

                    CupertinoButton(
                        color: Colors.blue,
                        onPressed: () {
                          print(filename);
                          if (filename == "no image" || filename == null) {
                            showsuccesssnackbar(context, "Please Pick Image");
                          }
                          if (valuechoose == null || valuechoose == null) {
                            showsuccesssnackbar(
                                context, "Please Select Categories");
                          }

                          if (_formkey.currentState!.validate()) {
                            setState(() {});
                            _showdialog(context, filename);
                          } else {
                            setState(() {});
                            return null;
                          }
                        },
                        child: Text('Upload')),
                    // CupertinoButton(
                    //     color: Colors.blue,
                    //     onPressed: () {
                    //       geturl(filename);
                    //     },
                    //     child: Text('Get URL')),
                    // CupertinoButton(
                    //     color: Colors.blue,
                    //     onPressed: () {
                    //       uploadfile(filename);
                    //     },
                    //     child: Text('Upload To Firebase')),

                    // TextButton(
                    //     onPressed: () {
                    //       geturl(filename);
                    //     },
                    //     child: Text('get url')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  File? file;
  String? fileurl;
  String? data;
  _showmessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("success"),
              actions: [
                CupertinoDialogAction(
                  child: Text("Sucess"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  _showdialog(BuildContext context, dynamic filename) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("Add New Item"),
              content: Column(
                children: [
                  Text("Categorie: " + "$valuechoose"),
                  Text("Title: " + "$title"),
                  Text("Price: " + "$price" + " rs"),
                  Text("Weight: " + "$weight")
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context);
                    uploadfile(filename);
                  },
                )
              ],
            ));
  }

  Future getimage() async {
    final image = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (image == null) return;
    final path = image.files.single.path;
    setState(() {
      file = File(path!);
    });
  }

  uploadfile(filename) {
    try {
      final ref = FirebaseStorage.instance.ref('allcategories/$filename');
      return ref
          .putFile(file!)
          .whenComplete(() => geturl(filename))
          .whenComplete(() => datatofirestore())
          .whenComplete(() {
        print("Put File Done");
        titlectrl.clear();
        pricectrl.clear();
        weightctrl.clear();

        print('>>>>>>> complete <<<<<<');
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  geturl(filename) async {
    fileurl = await FirebaseStorage.instance
        .ref('allcategories/$filename')
        .getDownloadURL();

    print("$fileurl" + "lllllllllllllooooooooooooooodddddddddduuuuuu");
  }

  datatofirestore() async {
    await FirebaseFirestore.instance
        .collection('allcategories')
        .doc('${valuechoose?.toLowerCase()}' + '-id123')
        .collection('${valuechoose?.toLowerCase()}')
        .doc('${title?.toLowerCase()}' + '-id123')
        .set({
      'title': title,
      'price': int.parse(price!),
      'id': '${title?.toLowerCase()}' + '-id123',
      'weight': weight,
      'quantity': 0,
      'stock': 'In Stock',
      'bcimage': '$fileurl'
    }).whenComplete(() {
      print('sucess');
    });
  }

  fetchdata() {}
  void showsuccesssnackbar(BuildContext context, err) {
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

  // fetchdata() {
  //   CollectionReference collectionReference =
  //       FirebaseFirestore.instance.collection('pizza');
  //   collectionReference.snapshots().listen((snapshot) {
  //     setState(() {
  //       data = snapshot.docs[0]['pizza'].toString();
  //       print(data);
  //     });
  //   });
  //   return data;
  // }
}
