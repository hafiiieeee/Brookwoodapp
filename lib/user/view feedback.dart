import 'package:brookwoodapp/user/feedback.dart';
import 'package:brookwoodapp/user/post_complaint.dart';
import 'package:flutter/material.dart';

class View_feedback extends StatefulWidget {
  const View_feedback({Key? key}) : super(key: key);

  @override
  State<View_feedback> createState() => _View_feedbackState();
}

class _View_feedbackState extends State<View_feedback> {
  List Lview = [
    "Feedback1",
    "Feedback2",
    "Feedback3",
    "Feedback4",
    "Feedback5"
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('feedback'),),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: Lview.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
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
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder:  (context)=> feedbacks()));
        },
        tooltip: 'feedbacks',
        child: Icon(Icons.add),
      ),
    );
  }
}
