import 'dart:developer';

import 'package:cyra_ecommerce_project/constants.dart';
import 'package:cyra_ecommerce_project/detailpage.dart';
import 'package:cyra_ecommerce_project/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Category_productsPage extends StatefulWidget {
  String catname;
  int catid;

  Category_productsPage({required this.catid, required this.catname});

  @override
  State<Category_productsPage> createState() => _Category_productsPageState();
}

class _Category_productsPageState extends State<Category_productsPage> {
  @override
  Widget build(BuildContext context) {
    log("catname=" + widget.catname.toString());
    log("catid=" + widget.catid.toString());

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          title: Text(
            widget.catname,
            //  "Category name",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder(
            future: Webservice().fetchCatProduct(widget.catid),
            builder: (context, snapshot) {
              log("cat product length=" + snapshot.data!.length.toString());
              if (snapshot.hasData) {
                return StaggeredGridView.countBuilder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    // itemCount: 2,
                    itemCount: snapshot.data!.length,
                    crossAxisCount: 2,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          log("category product clicked...");

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailsPage(
                                id: product.id!,
                                name: product.productname!,
                                image: Webservice().imageurl+product.image!,
                                price: product.price.toString(),
                                description: product.description!);
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 100,
                                      maxHeight: 250,
                                    ),
                                    child: Image(
                                        image: NetworkImage(
                                      Webservice().imageurl + product.image!,
                                    )
                                        //     NetworkImage("https://5.imimg.com/data5/SELLER/Default/2023/6/314069169/JT/EL/DI/189638314/premium-quality-designer-leather-hand-bag-500x500.jpeg")
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          product.productname!,
                                          //    "Ladies Bags",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade600),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Rs." + product.price.toString(),
                                          // "2000",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.red.shade900,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (context) =>
                        const StaggeredTile.fit(1));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
