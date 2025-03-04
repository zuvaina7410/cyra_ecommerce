import 'dart:convert';
import 'dart:developer';
import 'package:cyra_ecommerce_project/models/product_model.dart';
import 'package:http/http.dart' as http;

import 'package:cyra_ecommerce_project/models/category_model.dart';

import '../models/orderdetailmodel.dart';
import '../models/user_model.dart';

class Webservice {
  final imageurl = 'http://bootcamp.cyralearnings.com/products/';
  static final mainurl = 'http://bootcamp.cyralearnings.com/';

  Future<List<CategoryModel>?> fetchCategory() async {
    try {
      final response = await http.get(Uri.parse(mainurl + 'getcategories.php'));

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load category');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<ProductModel>?> fetchProduct() async {
    try {
      final response =
          await http.get(Uri.parse(mainurl + 'view_offerproducts.php'));
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<ProductModel>?> fetchCatProduct(int catid) async {
    try {
      log("Cat id =" + catid.toString());
      final response = await http.post(
          Uri.parse(
              'http://bootcamp.cyralearnings.com/get_category_products.php'),
          body: {'catid': catid.toString()});
      if (response.statusCode == 200) {
        log("catid in string");
        log("response =" + response.statusCode.toString());
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<UserModel> fetchUser(String username) async {
    final response = await http.post(Uri.parse(mainurl + 'get_user.php'),
        body: {'username': username});
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load fetchUser');
    }
  }

  Future<List<OrderModel>?> fetchOrderDetails(String username) async {
    try {
      log("username order details webservice..." + username.toString());
      final response = await http.post(
          Uri.parse(mainurl + 'get_orderdetails.php'),
          body: {'username': username.toString()});
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
