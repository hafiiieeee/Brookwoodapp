import 'dart:convert';

import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/designs/buttonnavigation.dart';
import 'package:brookwoodapp/user/Registration.dart';
import 'package:brookwoodapp/user/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: log(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class log extends StatefulWidget {
  const log({Key? key}) : super(key: key);

  @override
  State<log> createState() => _logState();
}

class _logState extends State<log> {

  TextEditingController usernameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool _isLoading=false;
  bool _obscuretext = true;
  bool passwordVisible = false;

  late SharedPreferences localStorage;
  late int loginId ;
  String role = '';
  pressLoginButton() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'username': usernameController.text.trim(), //username for email
      'password': passwordController.text.trim()
    };
    var res = await Api().authData(data,'/api/login_users');
    var body = json.decode(res.body);
    if (body['success'] == true) {
print("loginbody${body}");
      role = body['data']['role'];
      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('role', role.toString());
      localStorage.setInt('login_id',  body['data']['login_id']);
localStorage.setInt('user_id',  body['data']['user_id']);
print(role);

      Navigator.push(context, MaterialPageRoute(builder: (context)=>navigation()));
    }
       else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(image: DecorationImage(
          image: AssetImage("images/loo.jpeg"),
          fit: BoxFit.cover
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   backgroundImage: AssetImage("images/im.jfif"
                //   ),
                // ),
                Text("Login",style: TextStyle(
                    fontSize: 38,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 30),
                TextField(
                  controller:usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",hintText: "username",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  obscureText: passwordVisible,
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "Password",hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      ), suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                  ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(
                          () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
                  ),

                ),
                // SizedBox(height: 15,width: 15,),
                // Text("forgot password?",style: TextStyle(
                //   fontSize: 15,
                //   color: Colors.black26,
                // ),),
                SizedBox(height: 30,),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.cyan,
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80)
                          ),
                          // padding: EdgeInsets.all(30)
                      ),
                      onPressed: (){
                        pressLoginButton();

                      }, child: Text("Log in")),
                ),
                SizedBox(height: 15,width: 15,),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30.0),
                  child: RichText(
                    text: TextSpan(
                        text: 'Don\t have an account?',
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 16),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => reg(),
                                  ));
                                })
                        ]),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                )
      ],
                  ),
          ),
        ),
    ),
    );
  }
}
