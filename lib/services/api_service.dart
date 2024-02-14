import 'dart:convert';

import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/user/cart_model.dart';
import 'package:brookwoodapp/user/order_model.dart';
import 'package:brookwoodapp/user/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  late SharedPreferences prefs;
  late int user_id;

  Future<List<Product>> fetchProducts() async {
    var response = await Api().getData('/api/get_product');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print((items));

      List<Product>products = List<Product>.from(
          items['data'].map((e) => Product.fromJson(e)).toList());
      return products;
    } else {
      List<Product>products = [];
      return products;
    }
  }

  Future<List<Product>> fetchProductss(int id) async {
    var response = await Api().getData('/api/productcategory/' + id.toString());
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print((items));

      List<Product>products = List<Product>.from(
          items['data'].map((e) => Product.fromJson(e)).toList());
      return products;
    } else {
      List<Product>products = [];
      return products;
    }
  }

  Future<List<CartModel>> fetchCart() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);

    var response = await Api().getData('/api/SingleCart/' + user_id.toString());
    if (response.statusCode == 200) {

      var items = json.decode(response.body);
      print((items));

      List<CartModel>products = List<CartModel>.from(
          items['data'].map((e) => CartModel.fromJson(e)).toList());
      return products;
    } else {
      List<CartModel>products = [];
      return products;
    }
  }

  Future<List<CartModel>> fetchData() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);

    var response = await Api().getData('/api/SingleCart/' + user_id.toString());
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final carts = responseData
          .map((json) => CartModel.fromJson(json))
          .where((product) => product.cartStatus == 0)
          .toList();
      return carts;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<List<OrderModel>> fetchOrder() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);

    var response = await Api().getData('/api/Singleorder/' + user_id.toString());
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print(("order items${items}"));

      List<OrderModel>order = List<OrderModel>.from(
          items['data'].map((e) => OrderModel.fromJson(e)).toList());

      return order;
    } else {
      List<OrderModel>order = [];
      return order;
    }
  }
}