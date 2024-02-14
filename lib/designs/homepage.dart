import 'dart:convert';

import 'package:brookwoodapp/designs/detail_package.dart';
import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/designs/augmented.dart';
import 'package:brookwoodapp/services/api_service.dart';
import 'package:brookwoodapp/user/cart.dart';
import 'package:brookwoodapp/user/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  CarouselController buttonCarouselController = CarouselController();
  late SharedPreferences prefs;
  late int user_id;
  bool _isLoading=false;
  List images = ['images/disc.webp', 'images/sale.png', 'images/sofaoff.jpg'];
  late List<Product> _products = <Product>[];
  List cart=[];
  List order=[];
  late final products;
  var product;
  ApiService client = ApiService();
  bool _isInCart = false;
  bool icn_change(int id) {
    final favIcn = _products.contains(id);

    print("favIcon${favIcn}");
    return favIcn;
  }
  void _onButtonPressed() {
    setState(() {
      product.isFavorite = !product.isFavorite;
    });
  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
  }
  @override
  void initState() {
    super.initState();

  }

  Future AddCart(int itemid) async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);
    print('login_id_complaint ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "user": user_id.toString(),
      "product": itemid.toString(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Brookwood',
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Colors.white, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
              CarouselSlider.builder(
                itemCount: 3,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(images[itemIndex]),
                        fit: BoxFit.cover),
                  ),
                ),
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(microseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder<List<Product>>(
                      future: client.fetchProducts(),
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
                                 product = snapshot.data![index];

                                return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          int id= snapshot.data![index].id;
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailpackage(id: id)));
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
                                                        "\₹  ${snapshot.data![index].price}(Inc GST%)".toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'LuxuriousRoman',
                                                        ),
                                                      ),
                                                      Row(
                                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Container(
                                                              height:20,
                                                              child: ElevatedButton(
                                                                  onPressed:(){
                                                                    setState(() {
                                                                      AddCart(snapshot
                                                                          .data![index].id);
                                                                   _onButtonPressed( );

                                                                    });

                                                                  },
                                                                  child:Text("Add to cart",style: TextStyle(fontSize: 12),),

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


                                        ])));
                              });
                        }
                        return Center(child: CircularProgressIndicator());
                      })
              )
            ])));
  }
}

/*import 'dart:convert';

import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:brookwoodapp/designs/Account_page.dart';
import 'package:brookwoodapp/designs/api.dart';
import 'package:brookwoodapp/designs/augmented.dart';
import 'package:brookwoodapp/designs/detail_package.dart';
import 'package:brookwoodapp/designs/model.dart';
import 'package:brookwoodapp/provider/provider_page.dart';
import 'package:brookwoodapp/user/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:brookwoodapp/user/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';*/

/*class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}*/

/*class _homeState extends State<home> {
  CarouselController buttonCarouselController = CarouselController();
   List images = ['images/disc.webp', 'images/sale.png', 'images/sofaoff.jpg'];
  bool _isLoading = false;
  late SharedPreferences prefs;
  late int user_id;
  late int pro_id;
  String name="";
  String detail="";
  String stock="";
  String img="";
  late int cart_id;
  late int gst;
  late String price;
  late int gprice;
  bool itemInCart = false;
  late int qty;

  List _loadprooducts = [];
  List _loadcarts = [];
  List items = [
    Model(
        image: "images/bedd.jpg",
        name: "EBANSAL Wooden Queen Size Bed",
        description: "",
        price: '₹36000.00(GST Included)'),
    Model(
        image: "images/dro.jpg",
        name: "Droppy",
        description: "",
        price: '₹30000.00'),
    Model(
        image: "images/table.jpg",
        name: "dinny Table",
        description: "",
        price: '₹5999.00'),
    Model(
        image: "images/sofa6.jpg",
        name: "Sofa bae",
        description: "",
        price: '₹21999.00 '),
    Model(
        image: "images/table1.jpg",
        name: "Allie wood",
        description: "",
        price: '₹39000.00'),
    Model(
        image: "images/table.jpg",
        name: "Wake up india",
        description: "",
        price: '₹45000.00'),
  ];

  Future getProducts() async {
    var res = await Api().getData('/api/get_product');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
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
*/ /*    setState(() {
      _loadprooducts = body['data'];
      print(_loadprooducts);
      // depart_id = body['data'][0]['_id'];
    });*/ /*
  }

  Future AddCart(int itemid) async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);
    print('login_id_complaint ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "user": user_id.toString(),
      "product": itemid.toString(),
      "quantity": "1",
    };
    print(data);
    var res = await Api().authData(data, '/api/addtocart');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);
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
  Future getCart() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);

    var res = await Api().getData('/api/SingleCart/'+user_id.toString());
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loadcarts =items;


      });
    } else {
      setState(() {
        _loadcarts = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
*/ /*    setState(() {
      _loadprooducts = body['data'];
      print(_loadprooducts);
      // depart_id = body['data'][0]['_id'];
    });*/ /*
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
    getCart();
  }

  @override
  Widget build(BuildContext context) {
    final object = Provider.of<Provider_class>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Brookwood',
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),
          CarouselSlider.builder(
            itemCount: 3,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(images[itemIndex]), fit: BoxFit.cover),
              ),
            ),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(microseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 4,
                  crossAxisCount: 2,
                  crossAxisSpacing: 3,
                ),
                itemCount: _loadprooducts.length,
                itemBuilder: (context, index) {
 return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detailpackage(
                                  id: pro_id,name:name,detail:detail*/ /*,price:price*/ /*,gst:gst,gprice:gprice,imag:img,stock:stock
                                )));
                      },
                      child: Stack(
                        children:[

                        GridTile(
                            //  key: ValueKey(_products[index]['id']),
                            footer: Container(
                              height: 60,
                              child: GridTileBar(
                                backgroundColor: Colors.black54,
                                title: Text(
                                  _loadprooducts[index]['product_name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'LuxuriousRoman',
                                  ),
                                ),
                                subtitle: Column(
                                  children: [
                                    Text(
                                      "\₹  ${_loadprooducts[index]['product_price']}+(GST ${_loadprooducts[index]['GST']}%)",
                                      style: const TextStyle(
                                        fontFamily: 'LuxuriousRoman',
                                      ),
                                    ),

                                    InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AugmentedRealityView(img:img)));

                                        },
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(Icons.camera_alt)))
                                  ],
                                ),
                                //   trailing:  Icon(Icons.shopping_cart),
                              ),
                            ),
                            child: Image.network(
                              Api().url + _loadprooducts[index]['image'],
                              fit: BoxFit.fitHeight,
                            )),
                          IconButton(
                            icon: Icon(
                              itemInCart ? Icons.favorite : Icons.favorite_border,
                              color: itemInCart ? Colors.red : null,
                            ),
                            onPressed: () {
                              setState(() {
                                AddCart(pro_id);
                                itemInCart = !itemInCart;
                              });
                            },
                          ),
                         */ /* GestureDetector(
                              onTap: () {
                                AddCart(pro_id);
                               */ /**/ /* object.favorites(
                                    items[index].image,
                                    items[index].name,
                                    items[index].price);*/ /**/ /*
                              },
                              child: _loadprooducts[index]['id']==_loadcarts[index]['id']
                                  ? CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              )
                                  : CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[300],
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              )),*/ /*
                        */ /*  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                AddCart(pro_id);
                                },
                               child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                )
                               ),
                          )*/ /*
                    ]
                      ),
                    ),
                  );
                }),
            */ /* GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detailpackage(
                                    id: pro_id,
                                  )));
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                height:100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://2cb1-117-243-138-126.ngrok-free.app" +
                                                  _loadprooducts[index]
                                                      ['image']),
                                          fit: BoxFit.cover))),
                              GestureDetector(
                                  onTap: () {
                                    AddCart();
                                    object.favorites(
                                        items[index].image,
                                        items[index].name,
                                        items[index].price);
                                  },
                                  child: object
                                          .icn_change(items[index].name)
                                      ? CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.grey,
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.grey[300],
                                          child: Icon(
                                            Icons.favorite_border,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        )),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(_loadprooducts[index]['product_name'],style: TextStyle(fontSize: 15),)),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                "₹" +
                                    _loadprooducts[index]['product_price']
                                        .toString() +
                                    "(GST Included)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )),
                        ),
                        IconButton(
                            onPressed: () {
                              AugmentedRealityPlugin(
                                  "https://2cb1-117-243-138-126.ngrok-free.app${_loadprooducts[index]['image']}");

                              print(
                                  "https://2cb1-117-243-138-126.ngrok-free.app${_loadprooducts[index]['image']}");
                            },
                            icon: Icon(Icons.camera_alt))
                      ],
                    ),
                  );*/ /* */ /*
                }),*/ /*
          )
        ]),
      ),
    );
  }
}*/
