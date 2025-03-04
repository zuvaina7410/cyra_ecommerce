import 'package:cyra_ecommerce_project/cartpage.dart';
import 'package:cyra_ecommerce_project/constants.dart';
import 'package:cyra_ecommerce_project/login.dart';
import 'package:cyra_ecommerce_project/orderdetailspage.dart';
import 'package:cyra_ecommerce_project/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;

import 'home.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                " E-COMMERCE ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: maincolor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                " Home ",
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              },
            ),
            ListTile(
              leading: badges.Badge(
                showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                badgeContent: Text(
                  context.watch<Cart>().getItems.length.toString(),
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
              ),
              title: const Text(
                " Cart  ",
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartPage();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text(
                " Order Details ",
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return OrderdetailsPage();
                 }));
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(
                Icons.power_settings_new_rounded,
                color: Colors.red,
              ),
              title: const Text(
                " Logout ",
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", false);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
