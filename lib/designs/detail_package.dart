import 'dart:convert';

import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/user/payment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detailpackage extends StatefulWidget {
  final int id;
  Detailpackage(
      {required this.id,
     });

  @override
  State<Detailpackage> createState() => _DetailpackageState();
}

class _DetailpackageState extends State<Detailpackage> {
  String name = "";
  late int category;
    int  price=0;
   int  GST=0;
  int productprice=0 ;
  String detail = "";
  String image = "";
  String stock = "";
  late SharedPreferences prefs;
 late int remid,ids;
  bool _isLoading=false;
  late int user_id;
   @override
  initState() {
    super.initState();
    remid = widget.id;
    _viewPro();
  }
 /* Future<void> display() async{
    name=widget.id;
  }*/

  Future AddCart() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);
    print('login_id_complaint ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "user": user_id.toString(),
      "product": ids.toString(),
      "quantity": "1",
    };
    //   print(data);
    var res = await Api().authData(data, '/api/addtocart');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      //   print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
 Future<void> _viewPro() async {
     remid = widget.id;
    print("id${remid}");
    var res = await Api().getData('/api/single_product/' + remid.toString());
    var body = json.decode(res.body);
    print("datas${body}");
    setState(() {

      ids= body['data']['id'];
      name = body['data']['product_name'];
      category = body['data']['category'];
      price =body['data']['price'];
      GST = body['data']['GST'];
      productprice = body['data']['product_price'];
      detail = body['data']['product_details'];
     image = body['data']['image'];
      print(image);
     stock = body['data']['stock'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(name),
        leading: IconButton(
            onPressed: () {
            Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                      Api().url+ image,
                      ),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LuxuriousRoman',
                      color: Color(0xFF8F371B),
                    ),
                  ),
              SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Product Details ' ,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name  : ' +name,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
                /*  SizedBox(
                    height: 10,
                  ), Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Category: ' + category.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 10,
                  ), Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Price: ' + price.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'GST: ${GST}% ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),  SizedBox(
                    width: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Total Amount:₹ ' + productprice.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 /*   Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Product Details ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      detail,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Available Stocks  ' + stock,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
              ]
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.yellow,
          child: InkWell(
            onTap: () {
              AddCart();
             // Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment()));

            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Add to cart',
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
