
import 'dart:convert';

import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/user/complaint.dart';
import 'package:brookwoodapp/user/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class complaints extends StatefulWidget {
  const complaints({Key? key}) : super(key: key);

  @override
  State<complaints> createState() => _complaintsState();
}

class _complaintsState extends State<complaints> {
  TextEditingController _compcontroller = TextEditingController();
  bool _isLoading = false;
  late SharedPreferences prefs;

  List department = [];
  var dropDownValue;
  late SharedPreferences localStorage;
  late int user_id;
  final _formKey = GlobalKey<FormState>();

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Future getProducts()async{
    var res = await Api().getData('/api/get_product');
    var body = json.decode(res.body);

    setState(() {
      department=body['data'];
      // depart_id = body['data'][0]['_id'];
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();

  }

  void addComplaint()async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('login_id') ?? 0);
    print('login_id_complaint ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "user":user_id.toString(),
      "complaint":dropDownValue,
      "date": formattedDate,
      "product": dropDownValue,
    };
    print(data);
    // if(data.image){
    //   var res = await Api().authData(data.image, '/upload');
    //
    // }
    var res = await Api().authData(data, '/api/complaint');
    var body = json.decode(res.body);

    if(body['success']==true)
    {
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(
        this.context, //add this so it uses the context of the class
        MaterialPageRoute(
          builder: (context) => complaint(),
        ), //MaterialpageRoute
      );
      //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xF5FFFFFF) ,
        bottomNavigationBar: ElevatedButton(
            style: ElevatedButton.styleFrom
              (backgroundColor: Colors.lightBlueAccent),
            onPressed: () {
              addComplaint();
              // Navigator.of(context).push( MaterialPageRoute(builder: (context)=>View_Comp()));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 115, left: 115),
              child: Text(
                'SUBMIT',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
        appBar: AppBar(
          title: Text("Complaint"),
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => complaint(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key:_formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(

                children: [

                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Complaint',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _compcontroller,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Complaint'),
                  ),

                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Products',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.maxFinite,
                    child: DropdownButtonFormField<String>(

                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)) ,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),

                        ),
                        hint: Text('Products', overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        value: dropDownValue,
                        items: department
                            .map((type) => DropdownMenuItem<String>(
                          value: type['id'].toString(),
                          child: Text(
                            type['product_name'].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                            .toList(),
                        onChanged: (type) {
                          setState(() {
                            dropDownValue = type;
                          });
                        }),
                  ),


                ],
              ),
            ),
          ),
        ));
  }


}