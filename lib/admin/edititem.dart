import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_bakery_shop/admin/AdminGetcategoriesitems.dart';

class AdminAllcategories extends StatelessWidget {
  const AdminAllcategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      color: Colors.white,
      child: SafeArea(
        child:
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     SingleChildScrollView(
            //       child: Column(
            //         children: [
            StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('allcategories')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Card(
                    shadowColor: Colors.orange[200],
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      splashColor: Colors.orange[500],
                      onTap: () {
                        adminontapofcategories(context,
                            "${snapshot.data.docs[index]['forquery']}");
                      },
                      child: Container(
                        height: 220,
                        width: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                height: 120,
                                child: Image(
                                  image: NetworkImage(
                                      "${snapshot.data.docs[index]['image']}"),
                                  fit: BoxFit.scaleDown,
                                )),
                            // CircleAvatar(
                            //     backgroundImage: NetworkImage(
                            //         snapshot.data.docs[index]
                            //             ['bcimage'])),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${snapshot.data.docs[index]['title']}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        //       allcategoriesviewer(
        //           "assets/images/bread.png", "Bread", 1, context, 'bread'),
        //       allcategoriesviewer(
        //           "assets/images/bun.png", "Bun", 1, context, 'bun'),
        //       allcategoriesviewer(
        //           "assets/images/cake.png", "Cake", 5, context, 'cake'),
        //     ],
        //   ),
        // ),
        // Column(
        //   children: [
        //     allcategoriesviewer(
        //         "assets/images/cookie.png", "Cookie", 5, context, 'cookie'),
        //     allcategoriesviewer("assets/images/pizzabase.png", "Pizza Base",
        // 5, context, 'pizzabase'),
        // ],
        // )
        // ],
      ),
      // ),
    ));
  }

  adminallcategoriesviewer(String imagename, String itemname, double size,
      BuildContext context, String forquery) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Card(
        shadowColor: Colors.orange[200],
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          splashColor: Colors.orange[500],
          onTap: () {
            adminontapofcategories(context, forquery);
          },
          child: Container(
            height: 220,
            width: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Image.asset(
                    imagename,
                    scale: size,
                  ),
                ),
                // CircleAvatar(
                //     backgroundImage: NetworkImage(
                //         snapshot.data.docs[index]
                //             ['bcimage'])),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        itemname,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  adminontapofcategories(BuildContext context, String forquery) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AdminGetcategoriesitems(
        itemname: forquery,
      );
    }));
  }
}
