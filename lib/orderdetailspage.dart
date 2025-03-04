import 'dart:developer';

import 'package:cyra_ecommerce_project/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class OrderdetailsPage extends StatefulWidget {
  const OrderdetailsPage({super.key});

  @override
  State<OrderdetailsPage> createState() => _OrderdetailsPageState();
}

class _OrderdetailsPageState extends State<OrderdetailsPage> {
  String? username;
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
    log("isLogged in orderdetailpage=" + username.toString());
  }

  @override
  Widget build(BuildContext context) {
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
            )),
        title: const Text(
          "Order Details",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: Webservice().fetchOrderDetails(username.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return
                  //   }

                  //  })

                  ListView.builder(
                      //  itemCount: 2,
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        log("legth of order details length="+snapshot.data!.length.toString());
                        log("order details payment method="+snapshot.data![index].paymentmethod.toString());
                        final order_details = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 0,
                            color: Colors.pink.shade100,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: ExpansionTile(
                              trailing: Icon(Icons.arrow_drop_down),
                              textColor: Colors.black,
                              collapsedTextColor: Colors.black,
                              iconColor: Colors.red,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    DateFormat.yMMMEd()
                                        .format(order_details.date),
                                    //  "12-03-2023",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    order_details.paymentmethod.toString(),

                                    //  "Online",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromARGB(255, 6, 85, 11)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    order_details.totalamount.toString() +
                                        //  "20000"
                                        "/-",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.red.shade900),
                                  ),
                                ],
                              ),
                              children: [
                                ListView.separated(
                                  // itemCount: 1,
                                  itemCount: order_details.products.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 25),
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemBuilder: (context, int index) {
                                    //    List<Option> options = quiz.options;
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: SizedBox(
                                        height: 100,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 80,
                                              width: 100,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 9),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            Webservice()
                                                                    .imageurl +
                                                                order_details
                                                                    .products[
                                                                        index]
                                                                    .image
                                                            //""
                                                            ),
                                                        fit: BoxFit.fill),
                                                  ),
                                                  //child:Image.network(product.imagesUrl.first)
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      order_details
                                                          .products[index]
                                                          .productname,

                                                      // "product name",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .grey.shade700),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          order_details
                                                              .products[index]
                                                              .price
                                                              .toString(),

                                                          // "2000",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors.red
                                                                  .shade900),
                                                        ),
                                                        Text(
                                                          // "2"
                                                          order_details
                                                                  .products[
                                                                      index]
                                                                  .quantity
                                                                  .toString() +
                                                              "X",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors.red
                                                                  .shade900),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
