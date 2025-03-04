import 'dart:developer';

import 'package:cyra_ecommerce_project/constants.dart';
import 'package:cyra_ecommerce_project/home.dart';
import 'package:cyra_ecommerce_project/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';


class DetailsPage extends StatelessWidget {
  String name, price, image, description;
  int id;
  DetailsPage(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.description});

  //const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    log("detail page id =" + id.toString());
    log("detail page name =" + name.toString());
    log("detail page description =" + description.toString());
    log("detail page image =" + image.toString());
    print('image details=' + image.toString());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: NetworkImage(
                        image,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: (20)),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          name,
                          //"Shoes",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600),
                        ),
                      ),
                      Text(
                        "Rs." + price.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade900,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        description,
                        textScaleFactor: 1.1,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
                    print('price=='+double.parse(price).toString());
                    var existingItemCart =context.read<Cart>().getItems.firstWhereOrNull((element)=>element.id==id);
                  if(existingItemCart != null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    content:Text("This item already in cart",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "muli",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    )
                    )
                    );
                }
                else {

                context.read<Cart>().addItem(id, name, double.parse(price), 1, image);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    content:Text("Added to Cart",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "muli",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    ) ));

                }
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: maincolor),
              child: Center(
                child: Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
