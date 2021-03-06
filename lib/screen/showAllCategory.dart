import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import 'manage_categories.dart';

class ShowAllCategory extends StatefulWidget {
  const ShowAllCategory({Key? key}) : super(key: key);

  @override
  _ShowAllCategoryState createState() => _ShowAllCategoryState();
}

class _ShowAllCategoryState extends State<ShowAllCategory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Grinta",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: size.height * 0.1,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Category Items",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Container(
                  height: size.height * 0.64,
                  width: double.infinity,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("categories")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> querySnapshot) {
                        if (querySnapshot.hasError) {
                          return Text("Some Error Occurs");
                        }
                        if (querySnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          final list = querySnapshot.data!.docs;

                          return list.isEmpty
                              ? Center(
                                  child: Text(
                                    "No Category Available",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: CachedNetworkImage(
                                        imageUrl: list[index]["category_img"],
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: size.height * 0.3,
                                          margin: EdgeInsets.all(
                                              size.height * 0.007),
                                          alignment: Alignment.bottomLeft,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                              color: Colors.grey,
                                              border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            height: size.height * 0.14,
                                            decoration: BoxDecoration(
                                                color: Colors.black38,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            padding: EdgeInsets.only(
                                              left: size.width * 0.04,
                                              right: size.width * 0.04,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Text(
                                                        list[index]
                                                            ["category_name"],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  behavior: HitTestBehavior
                                                      .deferToChild,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top:
                                                            size.height * 0.01),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                size.height *
                                                                    0.01),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(50),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      50)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          FontAwesome5.trash,
                                                          color: Colors.red,
                                                          size: size.height *
                                                              0.04,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    querySnapshot.data!.docs
                                                        .forEach((doc) {
                                                      if (list[index][
                                                              "category_name"] ==
                                                          doc["category_name"]) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'categories')
                                                            .doc(doc.id)
                                                            .delete()
                                                            .then((value) => print(
                                                                "User Deleted"))
                                                            .catchError(
                                                                (error) => print(
                                                                    "Failed to delete user: $error"));
                                                        print(doc[
                                                            "category_name"]);
                                                        FirebaseStorage.instance
                                                            .refFromURL(list[
                                                                    index][
                                                                "category_img"])
                                                            .delete();
                                                      }
                                                    });
                                                    var snackBar = SnackBar(
                                                        content: Text(
                                                            'Product Deleted Successfully'));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    );
                                  });
                        }
                      }),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  height: size.height * 0.08,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: SizedBox(
                    height: 20,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageCategories()));
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.black87),
                      child: Text(
                        "Add Category",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
