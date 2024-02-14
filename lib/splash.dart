
import 'dart:async';

import 'package:brookwoodapp/designs/buttonnavigation.dart';
import 'package:brookwoodapp/user/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  String user = "brookuser";

  String role="";
  late SharedPreferences localStorage;
  Future<void> checkRoleAndNavigate() async {
    localStorage = await SharedPreferences.getInstance();
    role = (localStorage.getString('role') ?? '');
    print(role);
    if (user == role) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>navigation()));

    }  else  {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context)=>Login()));
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 4);
    return Timer(duration, checkRoleAndNavigate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image(image: AssetImage("images/ponnus-1.png"),
      ),
    );
  }
}
