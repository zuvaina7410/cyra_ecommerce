import 'dart:developer';

import 'package:cyra_ecommerce_project/category_products.dart';
import 'package:cyra_ecommerce_project/constants.dart';
import 'package:cyra_ecommerce_project/detailpage.dart';
import 'package:cyra_ecommerce_project/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        centerTitle: true,
        backgroundColor: maincolor,
        title: Text(
          "E-COMMERCE",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Category",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: maincolor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: Webservice().fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // itemCount: 12,

                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                log("Clicked category");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Category_productsPage(
                                    catid: snapshot.data![index].id!,
                                    catname: snapshot.data![index].category!,
                                  );
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(34, 247, 136, 202)),
                                child: Center(
                                  child: Text(
                                    //  "Category Name"
                                    snapshot.data![index].category!,

                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: maincolor),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            SizedBox(
              height: 20,
            ),
            Text(
              "Offer Products",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: maincolor),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future: Webservice().fetchProduct(),
                  builder: (context, snapshot) {
                    log("product length==" + snapshot.data!.length.toString());
                    if (snapshot.hasData) {
                      return Container(
                        // color: Colors.yellow,
                        child: StaggeredGridView.countBuilder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            //itemCount: 14,
                            itemCount: snapshot.data!.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              final product = snapshot.data![index];
                              //  log("product ==" + product.id.toString());
                              return InkWell(
                                onTap: () {
                                  log("GridView Clicked..");
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailsPage(
                                        id: product.id!,
                                        name: product.productname!,
                                        image: Webservice().imageurl +
                                            product.image!,
                                        price: product.price.toString(),
                                        description: product.description!);
                                    print("home==image" +
                                        Webservice().imageurl +
                                        product.image!);
                                  }));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 250, 249, 249),
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
                                                minHeight: 100, maxHeight: 250),
                                            child: Image(
                                              image: NetworkImage(
                                                Webservice().imageurl +
                                                    product.image!,
                                                //   "https://media.istockphoto.com/id/636379014/photo/hands-forming-a-heart-shape-with-sunset-silhouette.jpg?s=612x612&w=0&k=20&c=CgjWWGEasjgwia2VT7ufXa10azba2HXmUDe96wZG8F0=",
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  product.productname!,
                                                  //  "Shoes",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Rs." +
                                                      product.price.toString(),
                                                  // " 2000 ",
                                                  style: TextStyle(
                                                    fontSize: 17,
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
                                const StaggeredTile.fit(1)),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
