import 'package:brookwoodapp/designs/placeorder.dart';
import 'package:brookwoodapp/designs/profile.dart';
import 'package:brookwoodapp/user/complaint.dart';
import 'package:brookwoodapp/user/feedback.dart';
import 'package:brookwoodapp/user/feedback/addfeed.dart';
import 'package:brookwoodapp/user/feedback/viewfeedback.dart';
import 'package:brookwoodapp/user/login.dart';
import 'package:brookwoodapp/user/view%20feedback.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account_page extends StatefulWidget {
  const Account_page({Key? key}) : super(key: key);

  @override
  State<Account_page> createState() => _Account_pageState();
}

class _Account_pageState extends State<Account_page> {

  late SharedPreferences localStorage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 38,
          ),
          child: Column(
            children: [

              Card(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Account settings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceOrder()));
                      },

                      child: ListTile(
                        leading: Icon(
                          Icons.add_box_outlined,
                          color: Colors.blue[900],
                        ),
                        title: Text(
                          'Orders',
                          style:
                         TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => profile()));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color:Colors.blue[900],
                        ),
                        title: Text(
                          'Edit profile',
                          style: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.w400),
                          ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                        ),

                      ),

                    // ListTile(
                    //   leading: Icon(
                    //     Icons.location_on_outlined,
                    //     color: Colors.blue[900],
                    //   ),
                    //   title: Text(
                    //     'saved Address',
                    //     style:
                    //     TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    //   ),
                    //   trailing: Icon(
                    //     Icons.arrow_forward_ios,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: (){
                    //
                    //   },
                    //   child: ListTile(
                    //     leading: Icon(
                    //       Icons.language,
                    //       color: Colors.blue[900],
                    //     ),
                    //     title: Text(
                    //       'Select Language',
                    //       style:
                    //       TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    //     ),
                    //     trailing: Icon(
                    //       Icons.arrow_forward_ios,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewFeed ()));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.feedback,
                          color: Colors.blue[900],
                        ),
                        title: Text(
                          'Feedback',
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>complaint()));
                  },

                    child:ListTile(
                      leading: Icon(
                        color: Colors.blue[900],
                        Icons.messenger_outline,
                      ),
                      title: Text(
                        'Complaints',
                        style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                      ),

                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                ),
          ]
              ),

      ),
              SizedBox(height: 15,width: 15,),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.white54),
                  onPressed: () async {
                    localStorage = await SharedPreferences.getInstance();
                    localStorage.setBool('login', true);
                    Navigator.pushReplacement(context,
                        new MaterialPageRoute(builder: (context) => Login()));

                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


