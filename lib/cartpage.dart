import 'package:cyra_ecommerce_project/constants.dart';
import 'package:cyra_ecommerce_project/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkoutpage.dart';

class CartPage extends StatelessWidget {
  List<CartProduct> cartList = [];

  //const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
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

//widget.back,
        title: const Text(
          "Cart",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        actions: [
          context.watch<Cart>().getItems.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    context.read<Cart>().clearCart();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                ),
        ],
      ),
      body: context.watch<Cart>().getItems.isEmpty
          ? Center(
              child: Text("Empty Cart"),
            )
          : Consumer<Cart>(builder: (context, cart, child) {
              cartList = cart.getItems;
              return ListView.builder(
                  //   itemCount: 12,
                  itemCount: cart.count,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 9.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              cartList[index].imagesUrl),
                                          fit: BoxFit.fill),
                                    ),
                                    //child:Image.network(product.imagesUrl.first)
                                  ),
                                ),
                              ),
                              Flexible(
                                  child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        // cart.getItems[index].name!,
                                        cartList[index].name!,
                                        //  "product name",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade700),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            //cart.getItems[index].price.toString(),
                                            cartList[index].price.toString(),
                                            // "2000",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.red.shade600),
                                          ),
                                          Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    cart.getItems[index].qty ==
                                                            1
                                                        ? cart.removeItem(cart
                                                            .getItems[index])
                                                        : cart.reduceByOne(cart
                                                            .getItems[index]);
                                                  },
                                                  icon: cartList[index].qty == 1
                                                      ? Icon(
                                                          Icons.delete,
                                                          size: 18,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .minimize_rounded,
                                                          size: 18,
                                                        ),
                                                ),
                                                Text(
                                                  //cart.getItems[index].qty.toString(),
                                                  cartList[index]
                                                      .qty
                                                      .toString(),
                                                  //  "2",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color:
                                                          Colors.red.shade900),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      cart.increment(
                                                          cartList[index]);
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 18,
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total : " + context.watch<Cart>().totalPrice.toString(),
              // "Total : ",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900),
            ),
            InkWell(
              onTap: () {
                context.read<Cart>().getItems.isEmpty
                    ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        content: Text(
                          "Cart is empty!!!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ))
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                        return CheckoutPage(cart: cartList);
                      }));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: maincolor),
                child: Center(
                  child: Text(
                    "Order Now",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
