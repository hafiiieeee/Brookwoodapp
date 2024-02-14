
import 'dart:convert';

import 'package:brookwoodapp/designs/detail_package.dart';
import 'package:brookwoodapp/designs/homepage.dart';
import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/designs/augmented.dart';
import 'package:brookwoodapp/services/api_service.dart';
import 'package:brookwoodapp/user/cart.dart';
import 'package:brookwoodapp/user/product_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCateg extends StatefulWidget {
  late int id;


  DetailCateg({required this.id});

  @override
  State<DetailCateg> createState() => _DetailCategState();
}

class _DetailCategState extends State<DetailCateg> {
  List _loadprooducts = [];
  late SharedPreferences prefs;
  late int user_id;
  bool _isLoading=false;
  bool _isInCart = false;
 late int cid;
  void _onButtonPressed() {
    setState(() {
      _isInCart = !_isInCart;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
  }
  ApiService client = ApiService();
  Future getProducts() async {
    int cid=widget.id;
    print("id${cid}");
    var res = await Api().getData('/api/productcategory/'+cid.toString());

    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print("load${items}");
      setState(() {
        _loadprooducts = items;

      });
    } else {
      setState(() {
        _loadprooducts = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
/*    setState(() {
      _loadprooducts = body['data'];
      print(_loadprooducts);
      // depart_id = body['data'][0]['_id'];
    });*/
  }

  Future AddCart(int itemid) async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);
  //  print('login_id_complaint ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "user": user_id.toString(),
      "product": itemid.toString(),
      "quantity": "1",
    };
   // print(data);
    var res = await Api().authData(data, '/api/addtocart');
    var body = json.decode(res.body);

    if (body['success'] == true) {
     // print(body);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getProducts();
     cid=widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          },
              icon: Icon(Icons.arrow_back)),
        ),
      body: FutureBuilder<List<Product>>(
          future: client.fetchProductss(cid),
          builder: (BuildContext context,
              AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 4,
                    crossAxisCount: 2,
                    crossAxisSpacing: 3,
                  ),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    var product = snapshot.data![index];

                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                            onTap: () {
                              int id=snapshot.data![index].id;
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailpackage(id:id)));
                            },
                            child: Stack(children: [
                              GridTile(
                                //  key: ValueKey(_products[index]['id']),
                                  footer: Container(
                                    height: 60,
                                    child: GridTileBar(
                                      backgroundColor:
                                      Colors.black54,
                                      title: Text(
                                        snapshot.data![index].name,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.bold,
                                          fontFamily:
                                          'LuxuriousRoman',
                                        ),
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            "\₹  ${snapshot.data![index].price}(Inc GST%)",
                                            style: const TextStyle(
                                              fontFamily:
                                              'LuxuriousRoman',
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                  height:20,
                                                  child: ElevatedButton(
                                                    onPressed:(){
                                                      setState(() {
                                                        AddCart( snapshot
                                                            .data![index].id);
                                                        _onButtonPressed();
                                                        /*  AddCart( snapshot
                                                                          .data![index].id);
                                                                      product.isFavorite = !product.isFavorite;*/
                                                      });

                                                    },
                                                    child:product.isFavorite ?  Text("Go to cart"): Text("Add to cart"),
                                                    /*  onPressed: (){
                                                                AddCart( snapshot
                                                                    .data![index].id);
                                                              }, child: Text('Add to cart')*/
                                                  )),
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => AugmentedRealityView(
                                                                img: snapshot
                                                                    .data![index]
                                                                    .imageUrl)));
                                                  },
                                                  child: Align(
                                                      alignment: Alignment
                                                          .centerRight,
                                                      child: Icon(Icons
                                                          .camera_alt))),
                                            ],
                                          )
                                        ],
                                      ),

                                      //   trailing:  Icon(Icons.shopping_cart),
                                    ),
                                  ),
                                  child: Image.network(
                                    Api().url +
                                        snapshot
                                            .data![index].imageUrl,
                                    fit: BoxFit.fitHeight,
                                  )),

                              /*  IconButton(
                                            icon: Icon(
                                              product.isFavorite ? Icons.favorite : Icons.favorite_border,
                                              color: product.isFavorite ? Colors.red : null,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                AddCart( snapshot
                                                    .data![index].id);
                                                product.isFavorite = !product.isFavorite;
                                              });
                                            },
                                          ),*/
                            ])));
                  });
            }
            return Center(child: CircularProgressIndicator());
          })
    );

  }
}
