
import 'dart:convert';

import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/designs/homepage.dart';
import 'package:brookwoodapp/user/feedback/viewfeedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFeed extends StatefulWidget {
  const AddFeed({Key? key}) : super(key: key);

  @override
  State<AddFeed> createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
TextEditingController controller=TextEditingController();
  double? _ratingValue;
  late SharedPreferences localStorage;
  late int user_id;
  List products=[];

var dropDownValue;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  void initState() {
  // TODO: implement initState
  super.initState();
  getProducts();

}
Future getProducts()async{
  var res = await Api().getData('/api/get_product');
  var body = json.decode(res.body);

  setState(() {
    products=body['data'];
    // depart_id = body['data'][0]['_id'];
  });
}
@override

bool _isLoading=false;
void registerFeed()async {
  localStorage = await SharedPreferences.getInstance();
  user_id = (localStorage.getInt('user_id') ?? 0);
  print('user_id ${user_id}');
  setState(() {
    _isLoading = true;
  });

  var data = {
    "user": user_id.toString(),
    "feedback": controller.text.trim(),
    "rating": _ratingValue.toString(),
    "date":formattedDate,
    "product":dropDownValue
  };
  print("patient data${data}");
  var res = await Api().authData(data,'/api/review');
  var body = json.decode(res.body);
  print('res${body}');
  if(res.statusCode == 201) {

    Fluttertoast.showToast(
      msg: body['message'].toString(),
      backgroundColor: Colors.grey,
    );

    Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
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

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback",style: TextStyle(color:Colors.black),),
        backgroundColor: Colors.white ,
        leading:IconButton(onPressed:(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ViewFeed()));
        },
            icon: Icon(Icons.arrow_back,color:Colors.black)),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width:w,
                height:h ,
                child: Card(
                  child:Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text("Rate Your Experience-",style:TextStyle(
                        fontSize:28,
                        fontWeight: FontWeight.w100,
                        ),),
                    SizedBox(height: 20,),
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
                        hint: Text('Products'),
                        value: dropDownValue,
                        items: products
                            .map((type) => DropdownMenuItem<String>(
                          value: type['id'].toString(),
                          child: Text(
                            type['product_name'].toString(),
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

                  SizedBox(height: 20),
                  Text("Are you Satisfied with the Service?",style:TextStyle(
                      fontSize:20,
                      fontWeight: FontWeight.w500,
                    ),),
                  SizedBox(height: 20,),
                    RatingBar(
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(

                            full: const Icon(Icons.star, color: Colors.orange),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.orange,
                            ),
                            empty: const Icon(
                              Icons.star_outline,
                              color: Colors.orange,
                            )),
                        onRatingUpdate: (value) {
                          setState(() {
                            _ratingValue = value;
                          });
                        }),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width:w,
                    height: 190,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),

                    child: TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Field can't be empty";
                        }
                      },
                      controller: controller,
                      decoration: InputDecoration(
                          hintText:"Tell us on how can we improve..." ,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ), enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0
                          )
                      ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                    ),
                  ),


                  SizedBox(height: 30,),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        registerFeed();
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                      },
                      child: Container(
                        width: w*0.5,
                        height:h*0.08,
                        color:  Colors.blueAccent,
                        child: Center(
                          child: Text("Submit",style:TextStyle(
                              fontSize:36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          )),
                        ),
                      ),
                    ),
                  ),

          ],
        ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
