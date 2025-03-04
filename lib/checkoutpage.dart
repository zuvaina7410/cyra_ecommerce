import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce_project/constants.dart';
import 'package:cyra_ecommerce_project/home.dart';
import 'package:cyra_ecommerce_project/models/user_model.dart';
import 'package:cyra_ecommerce_project/provider/cart_provider.dart';
import 'package:cyra_ecommerce_project/razorpay.dart';
import 'package:cyra_ecommerce_project/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  List<CartProduct> cart;
  CheckoutPage({required this.cart});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedValue = 1;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  String? username;
  //Loading counter value on start
  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
    log("isLoggedIn = " + username.toString());
  }

  orderPlace(List<CartProduct> cart, String amount, String paymentmethod,
      String date, String name, String address, String phone) async {
    String jsondata = jsonEncode(cart);
    log('jsonData = ${jsondata}');
    final vm = Provider.of<Cart>(context, listen: false);
    //replace above line using getbuilder
    final response =
        await http.post(Uri.parse(Webservice.mainurl + "order.php"), body: {
      "username": username,
      "amount": amount,
      "paymentmethod": paymentmethod,
      "date": date,
      "quantity": vm.count.toString(),
      "cart": jsondata,
      "name": name,
      "address": address,
      "phone": phone,
    });
    if (response.statusCode == 200) {
      log(response.body);
      if (response.body.contains("Success")) {
        vm.clearCart();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Text(
            "YOUR ORDER SUCCESSFULLY COMPLETED",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      }
    }
  }

  String? name, address, phone;
  String? paymentmethod = "Cash On delivery";
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text(
          "CheckOut",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<UserModel>(
                  future: Webservice().fetchUser(username.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      name = snapshot.data!.name;
                      phone = snapshot.data!.phone;
                      address = snapshot.data!.address;

                      //                      }),)

                      return Card(
                        
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Name : ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      //"name"
                                      name.toString(),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Phone : ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // "phone",
                                      phone.toString(),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Address : ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Text(
                                        //"address",
                                        
                                        address.toString(),
                                        
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ));
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            RadioListTile(
              activeColor: maincolor,
              value: 1,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                  paymentmethod = "Cash On delivery";
                });
              },
              title: const Text(
                "Cash On Delivery",
                style: TextStyle(fontFamily: "muli"),
              ),
              subtitle: const Text(
                "Pay Cash At Home",
                style: TextStyle(fontFamily: "muli"),
              ),
            ),
            RadioListTile(
              activeColor: maincolor,
              value: 2,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                  paymentmethod = "Online";
                });
              },
              title: const Text(
                "Pay Now",
                style: TextStyle(fontFamily: "muli"),
              ),
              subtitle: const Text(
                "OnlinePayment",
                style: TextStyle(fontFamily: "muli"),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {return SuccessPage();},
            //   ),
            // );

            //   cart.getItems[index];
            String datetime = DateTime.now().toString();
            log("check out page=========datetime..."+datetime.toString());
          if(paymentmethod=="Online"){
                 Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) 
                {
                  return PaymentScreen(
                    cart: widget.cart,
                    amount: vm.totalPrice.toString(),
                    paymentmethod: paymentmethod.toString(),
                    date: datetime.toString(),
                    name: name.toString(),
                    phone: phone.toString(),
                    address: address.toString(),
                    

                  );
                  },
              ),
            );

          }else if(paymentmethod=="Cash On delivery"){

            orderPlace(widget.cart, vm.totalPrice.toString(), paymentmethod!,
                datetime, name!, address!, phone!);
}
          },
          child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: maincolor),
              child: Center(
                  child: Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ))),
        ),
      ),
    );
  }
}
