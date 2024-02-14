
import 'dart:convert';

import 'package:brookwoodapp/designs/emptycart.dart';
import 'package:brookwoodapp/designs/placeorder.dart';
import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/services/api_service.dart';
import 'package:brookwoodapp/user/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Democart extends StatefulWidget {
  const Democart({Key? key}) : super(key: key);

  @override
  State<Democart> createState() => _DemocartState();
}

class _DemocartState extends State<Democart> {
  ApiService client = ApiService();
  bool _isLoading = false;
  var product;
  late SharedPreferences prefs;
  List cart = [];
  bool isLoading = false;
  late int user_id, cart_id;
  late int qty;
  Future PlaceOrders() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);
    print('login_id_complaint ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "user": user_id.toString(),
    };
    print(data);
    var res = await Api().authData(data, '/api/order');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      cart.clear();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PlaceOrder()));
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
    else{
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body:cart.isEmpty
          ? EmptyCartImage() // Show empty cart image
          :
      FutureBuilder<List<CartModel>>(
        future: client.fetchCart(),
    builder: (BuildContext context,
    AsyncSnapshot<List<CartModel>> snapshot) {
    if (snapshot.hasData) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount:snapshot.data?.length,
        itemBuilder: (context, index) {
          product = snapshot.data![index];

          /*  product = cart[index];
          final firstWord = cart[index]['p_name'].split(' ').first;
          cart_id = cart[index]['id'];
          qty= int.parse(cart[index]['quantity']) ;*/
          return Card(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200]),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 120,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    Api().url +  snapshot.data![index].imageUrl),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            snapshot.data![index].name,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "₹"+ snapshot.data![index].price.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                          ),
                          onPressed: () {
                            setState(() {
                          //    _deleteData(cart[index]['id']);

                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              child: FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                               //     _decrement();
                                  });
                                },
                                backgroundColor: Colors.grey,
                                child:
                                Icon(Icons.remove, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${qty}'.toString(),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              child: FloatingActionButton(
                                onPressed: () {
                                  setState(() {

                                  //  _increment();

                                  });
                                },
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.add, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ));
        },);
    }
    return Center(child: CircularProgressIndicator());
    }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.yellow,
          child: InkWell(
            onTap: () {
              PlaceOrders();
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
