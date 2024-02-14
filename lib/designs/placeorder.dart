
import 'dart:convert';

import 'package:brookwoodapp/designs/homepage.dart';
import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/services/api_service.dart';
import 'package:brookwoodapp/user/order_model.dart';
import 'package:brookwoodapp/user/payment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  List order = [];
  ApiService client = ApiService();
  bool isLoading = false;
  late SharedPreferences localStorage;
  late int user_id;
  String price='';
  bool _isLoading=false;
  List images = ['images/disc.webp', 'images/sale.png', 'images/sofaoff.jpg'];
  _fetchOrder() async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getInt('user_id') ?? 0);
    print("id${user_id}");
    var res = await Api()
        .getData('/api/Singleorder/'+user_id.toString());
    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      var items = json.decode(res.body)['data'];
      print("order Items${items}");
      setState(() {
        order = items;
      });
    } else {
      order = [];
      Fluttertoast.showToast(
        msg:"Currently there is no data available",
        backgroundColor: Colors.grey,
      );
    }
  }
  Future totalId() async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getInt('user_id') ?? 0);
    print('login_id_complaint ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var res = await Api().getData('/api/order_price/'+user_id.toString());
    var body = json.decode(res.body);

    if (body['success'] == true) {
      price= body['data']['total_price'];
      print(price);
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
  void initState() {
    // TODO: implement initState
    super.initState();

    totalId();
    _fetchOrder();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
          },icon: Icon(Icons.arrow_back),
        ),
      ),
      body:/* FutureBuilder<List<OrderModel>>(
      future: client.fetchOrder(),
    builder: (BuildContext context,
    AsyncSnapshot<List<OrderModel>> snapshot) {
        print(snapshot);
    if (snapshot.hasData) {
    return */ ListView.builder(
            shrinkWrap: true,
            itemCount:order.length,
            itemBuilder: (BuildContext context, int index){
              int orderid=order[index]['id'];
              final firstWord = order[index]['product_name'].split(' ').first;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 90,
                              child: Image(image: NetworkImage(Api().url+ order[index]['image'])),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(firstWord),
                                  Text("Quantity : "+order[index]['quantity'].toString()),
                                  Text("Rs : "+order[index]['total_price'].toString()),
                                  // Text("Qty : "+order[index].quantity),
                                ],
                              ),
                            ),
                          ],
                        ),


                        /*  GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment()));
                  },
                )*/
                      ]
                  ),
                ),
              );
            }),
  /*  }
    return Center(child: CircularProgressIndicator());
    }),*/

      bottomNavigationBar: Row(
        children: [
          Material(
            color:  Color(0xffff8989),
            child:  SizedBox(
              height: kToolbarHeight,
              width: 100,
              child: Center(
                child: Text(price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.green,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment(price:price)));
                },
                child: const SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),


    );
  }
}
