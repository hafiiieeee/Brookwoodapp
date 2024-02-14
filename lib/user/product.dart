import 'dart:convert';

import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/designs/buttonnavigation.dart';
import 'package:brookwoodapp/designs/categdetail.dart';
import 'package:brookwoodapp/furniture/beds.dart';
import 'package:brookwoodapp/furniture/bookshelf.dart';
import 'package:brookwoodapp/furniture/cabinet.dart';
import 'package:brookwoodapp/furniture/diningtable.dart';
import 'package:brookwoodapp/furniture/officetable.dart';
import 'package:brookwoodapp/furniture/wardrobe.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../furniture/sofas.dart';

class product extends StatefulWidget {
  @override
  State<product> createState() => _productState();
}

class _productState extends State<product> {
  List navpage= [
    sofa(),
    beds(),
    diningtable(),
    officetable(),
    wardrobe(),
    bookshelf(),
    cabinet()

  ];
  bool _isLoading = false;
  late SharedPreferences prefs;
  List choices = ["images/sofa1.jpg"];
late int product_id;
  List department = [];
  Future getProducts()async{
    var res = await Api().getData('/api/category');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        department = items;

      });
    } else {
      setState(() {
        department = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
   /* setState(() {
      department=body['data'];
      // depart_id = body['data'][0]['_id'];
    });*/
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(
          title: Text("All products"),
        ),
            body: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 5.4,
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: department.length,
                  itemBuilder: (context, index) {
                    int categid=department[index]['id'];
                    return Center(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailCateg(id:categid)));

                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(Api().url+department[index]['image']
                              ),
                            ),
                            Text(department[index]['category_name'] ),
                          ],
                        ),
                      ),
                      //  Expanded(child: Icon(choice.images, size:50.0,)),

                    );
                  }
                  )
              ),
            

    );
  }
}
class Choice {
  const Choice({required this.title, required this.images});
  final String title;
  final String images;
}
const List<Choice> choices = const <Choice>[
  const Choice(title: 'Sofas', images:"images/sofa1.jpg"),
  const Choice(title: 'Beds',images:"images/bed4.jpg" ),
  const Choice(title: 'Dining Tables',images:"images/table1.jpg"),
  const Choice(title: 'Office Tables',images:"images/office1.webp"),
  const Choice(title: 'Wardobes',images:"images/wardrobe1.jpg" ),
  const Choice(title: 'bookshelf',images:"images/bookshelf.jpg" ),
  const Choice(title: 'cabinet',images:"images/cabinet1.webp" ),
];
/*
class SelectCard extends StatelessWidget {
   SelectCard({ required this.choice}) ;
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // children: <Widget>[
    children: [
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(choice.images
              ),
            ),
          //  Expanded(child: Icon(choice.images, size:50.0,)),
            Text(, ),
          ]
      ),
    ],
    )
    );
  }


}*/
