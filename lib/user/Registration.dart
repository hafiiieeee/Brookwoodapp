import 'dart:convert';

import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/user/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:reg(),
    );
  }
}*/
class reg extends StatefulWidget {
  const reg({Key? key}) : super(key: key);

  @override
  State<reg> createState() => _reg();
}

class _reg extends State<reg> {

  TextEditingController nameController=TextEditingController();
  TextEditingController houseController=TextEditingController();
  TextEditingController roadController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController stateController=TextEditingController();
  TextEditingController postController=TextEditingController();
  TextEditingController pincodeController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phone_numberController=TextEditingController();
  TextEditingController usernameController=TextEditingController();
  TextEditingController userpasswordController=TextEditingController();


  final formKey=GlobalKey<FormState>();
  bool _isLoading=false;
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      "fullname": nameController.text,
      "housename": houseController.text,
      "roadname":  roadController.text,
      "city": cityController.text,
      "state": stateController.text,
      "post": postController.text,
      "pincode":pincodeController.text,
      "email":emailController.text,
      "phone_number":phone_numberController.text,
      "username":usernameController.text,
      "userpassword":userpasswordController.text,


    };
    print(data);
    var res = await Api().authData(data,'/api/user_register');
    var body = json.decode(res.body);

    if(body['success']==true)
    {
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

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
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body:
      Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(image: DecorationImage(
            image: AssetImage("images/prof.jpg"),
            fit: BoxFit.cover
        )),
        child: SingleChildScrollView(
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
                    // Card(
                    //   margin: EdgeInsets.all(5),
                    //   child: TextFormField(
                    //     controller: postController,
                    //     decoration: InputDecoration(
                    //         labelText: "Post",
                    //         hintText: "Post",
                    //         hintStyle: TextStyle(color: Colors.white30),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //         )
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 5),
                    Card(
                      margin: EdgeInsets.all(5),
                      child:Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Please choose a data to use";
                            }
                          },
                        controller: usernameController,
                        decoration: InputDecoration(
                            labelText: "username",
                            hintText: "username",
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
                        child: TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Please choose a data to use";
                            }
                          },
                          obscureText: true,
                          controller: userpasswordController,
                          decoration: InputDecoration(
                              labelText: "userpassword",
                              hintText: "userpassword",
                              hintStyle: TextStyle(color: Colors.white30),
                            /*  border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              )*/
                          ),
                        ),
                      ),
                    ),
                        SizedBox(height:10),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(onPressed: (){
                            registerUser();
                          },
                            child: Text("Register"),
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
        );
  }
}
