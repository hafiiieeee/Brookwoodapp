import 'dart:convert';

import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/designs/buttonnavigation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {


  TextEditingController nameController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phone_numberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();

  late int user_id;
  String name = "";
  String ho = "";
  String road = "";
  String phn = "";
  String city = "";
  String state = "";
  String email = "";
  String post = "";
  String pin = "";
  late SharedPreferences prefs;
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;


  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);
    print('login_idupdate ${user_id}');
    var res = await Api()
        .getData('/api/single_user/' + user_id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['fullname'];
      ho = body['data']['housename'];
      road = body['data']['roadname'];
      city = body['data']['city'];
      state = body['data']['state'];
      post = body['data']['post'];
      phn = body['data']['phone_number'];
      email = body['data']['email'];
      pin = body['data']['pincode'];

      nameController.text = name;
      houseController.text = ho;
      roadController.text = road;
      emailController.text = email;
      cityController.text = city;
      stateController.text = state;
      pincodeController.text = pin;
      postController.text = post;
      phone_numberController.text = phn;
    });
  }

  void UpdateUser() async {
    setState(() {
      var _isLoading = true;
    });
    var data = {
      "fullname": nameController.text,
      "housename": houseController.text,
      "roadname": roadController.text,
      "city": cityController.text,
      "state": stateController.text,
      "post": postController.text,
      "pincode": pincodeController.text,
      "email": emailController.text,
      "phone_number": phone_numberController.text,
      "username": usernameController.text,
      "userpassword": userpasswordController.text,
    };
    print(data);
    var res = await Api().putData(
        data, '/api/update_user/' + user_id.toString());
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => navigation()));
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
        // backgroundColor: Colors.white,
        title: Text('My Profile '),
        // actions: [
        //   IconButton(onPressed:(){}, icon: Icon(Icons.logout))
        // ],
      ),
      body:Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(image: DecorationImage(
            image: AssetImage("images/prof.jpg"),
            fit: BoxFit.cover
        )),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child:SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text("Create a new account",style: TextStyle(
                        //   fontSize: 30,
                        //   fontStyle: FontStyle.normal,
                        //   fontWeight: FontWeight.bold,
                        // ),),
                        SizedBox(height: 2),

                        Card(

                            margin: EdgeInsets.all(5),
                            child:  Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                  validator: (value){
                                    if(value == null || value.isEmpty){
                                      return "Please choose a data to use";
                                    }
                                  },
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: "Full Name",
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(color: Colors.white30),
                                    /*  border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                          ),*/

                                  )
                              ),)
                        ),
                        SizedBox(height: 5),
                        Card(
                          margin: EdgeInsets.all(5),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:  TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please choose a data to use";
                                  }
                                },
                                controller: houseController,
                                decoration: InputDecoration(
                                  labelText: "House No,Building Name",
                                  hintText: "House No,Building Name ",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  /* border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )*/
                                ),)
                          ),
                        ),
                        SizedBox(height: 5),
                        Card(
                            margin: EdgeInsets.all(5),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:  TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please choose a data to use";
                                  }
                                },
                                controller: roadController,
                                decoration: InputDecoration(
                                  labelText: "Road Name,Area,Colony",
                                  hintText: "Road Name,Area,Colony",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  /*  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),*/
                                ),
                              ),)
                        ),
                        SizedBox(height: 5),
                        Card(
                          margin: EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child:  TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please choose a data to use";
                                  }
                                },
                                controller: cityController,
                                decoration: InputDecoration(
                                  labelText: "City",
                                  hintText: "City",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  /* border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )*/
                                )),
                          ),
                        ),
                        SizedBox(height: 5),
                        Card(
                            margin: EdgeInsets.all(5),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:  TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please choose a data to use";
                                  }
                                },
                                controller: stateController,
                                decoration: InputDecoration(
                                  labelText: "State",
                                  hintText: "State",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  /*  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )*/
                                ),
                              ),)
                        ),
                        SizedBox(height: 5),
                        Card(
                            margin: EdgeInsets.all(5),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:  TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please choose a data to use";
                                  }
                                },
                                controller: postController,
                                decoration: InputDecoration(
                                  labelText: "Post",
                                  hintText: "Post",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  /* border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )*/
                                ),
                              ),)
                        ),
                        SizedBox(height: 5),
                        Card(
                          margin: EdgeInsets.all(5),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:  TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please choose a data to use";
                                  }
                                },
                                controller: pincodeController,
                                decoration: InputDecoration(
                                  labelText: "Pincode",
                                  hintText: "Pincode",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  /*  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )*/
                                ),)
                          ),
                        ),
                        SizedBox(height: 5),
                        Card(
                          margin: EdgeInsets.all(5),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:  TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please choose a data to use";
                                  }
                                },
                                controller: phone_numberController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Phone Number",
                                  hintText: "Phone Number",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  /*  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )*/
                                ),)
                          ),
                        ),
                        SizedBox(height: 5),
                        Card(
                            margin: EdgeInsets.all(5),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:  TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please choose a data to use";
                                  }
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  /*  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )*/
                                ),
                              ),)
                        ),  SizedBox(height: 5),


                        SizedBox(height:10),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(onPressed: (){
                            UpdateUser();
                          },
                            child: Text("Update"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.cyan,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80),
                              ),
                              // padding: EdgeInsets.all(30)
                            ),
                          ),
                        ),
                      ],
                    ),
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