import 'dart:convert';

import 'package:brookwoodapp/designs/homepage.dart';
import 'package:brookwoodapp/services/api.dart';
import 'package:brookwoodapp/user/post_complaint.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class complaint extends StatefulWidget {
  const complaint({Key? key}) : super(key: key);

  @override
  State<complaint> createState() => _complaintState();
}

class _complaintState extends State<complaint> {
  List Lview = [
    "Complaint1",
    "Complaint2",
    "Complaint3",
    "Complaint4",
    "Complaint5"
  ];
  List _loaddisease = [];
  bool isLoading = false;
  late SharedPreferences localStorage;
  late int user_id;
  String complaint="";
  String dates="";
  String reply="";
  late bool isExpanded=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchDisease();
  }
  _fetchDisease() async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getInt('user_id') ?? 0);

    var res = await Api()
        .getData('/api/complaintsingle_view/'+user_id.toString());
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddisease = items;

      });
    }
    /*  var items = json.decode(res.body);
      print("items${items}");
      setState(() {
        complaint = items['data']['complaint'];

        dates = items['data']['date'];
        reply = items['data']['reply'].toString();
        //  _loaddisease = items;
      });*/
    else {
      setState(() {
        _loaddisease = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint'),
        leading: IconButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => home(),
          ));
        },
            icon: Icon(Icons.arrow_back)),
      ),
      body:Container(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
              children:<Widget> [
                Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Text("Complaints",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),
                ),
                SizedBox(height:20),
              /*  Card(
                    child:Container(
                        child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(complaint,),
                                          Text(dates),
                                        ],
                                      ),


                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children:[
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isExpanded = !isExpanded;
                                              });
                                            },
                                            child: isExpanded?Icon(Icons.arrow_drop_up):Icon(Icons.arrow_drop_down),
                                          ),
                                          Visibility(
                                            visible: isExpanded,
                                            child: AnimatedContainer(
                                              duration: Duration(milliseconds: 300),
                                              height: isExpanded ? 50.0 : 0.0,
                                              child:*//*reply == "null"? Text("No reply available"):*//* Text(reply),
                                            ),
                                          )
                                        ],
                                      ),
                                    )]
                              )]
                        )
                    )
                )*/
                  ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap:true,
                  itemCount: _loaddisease.length,
                  itemBuilder: (context,index){
                    return Card(
                        child:Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(_loaddisease[index]['complaint'],),
                                        Text(_loaddisease[index]['date']),
                                      ],
                                    ),


                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children:[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          child: isExpanded?Icon(Icons.arrow_drop_up):Icon(Icons.arrow_drop_down),
                                        ),
                                        Visibility(
                                          visible: isExpanded,
                                          child: AnimatedContainer(
                                            duration: Duration(milliseconds: 300),
                                            height: isExpanded ? 50.0 : 0.0,
                                            child:Text(_loaddisease[index]['replay']),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )


                    );
                  },
                )
              ]),

        ),

      ),
      /* ListView.builder(
          shrinkWrap: true,
          itemCount: Lview.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => complaints()));
                },
                  child: ListTile(
                    title: Text(
                      Lview[index],
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                    // trailing: ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.pink,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(60),
                    //       side: BorderSide(strokeAlign: BorderSide.strokeAlignCenter),
                    //     ),
                    //   ),
                    //   onPressed: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => complaint()));
                    //   },
                    //   child: Text("cancel"),
                    //
                    // ),
                  ),
                ),
              ),
            );
          }),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> complaints()
          ));
        },
        tooltip: 'Complaints',
        child: Icon(Icons.add),
      ),

    );
  }
}
