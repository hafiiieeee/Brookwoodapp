import 'package:brookwoodapp/user/complaint.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class feedbacks extends StatefulWidget {
  const feedbacks({Key? key}) : super(key: key);

  @override
  State<feedbacks> createState() => _feedbacksState();
}

class _feedbacksState extends State<feedbacks> {
  TextEditingController datecontroller=TextEditingController();
  // TextEditingController timecontroller=TextEditingController();
  String dropdownvalue = 'sofa';

  // List of items in our dropdown menu
  var items = [
    'Table',
    'Bed',
    'Chair',
    'sofa',
    'Bookshelf'

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('feedbacks'),
      ),
      body:  Column(
          children: [
            // Text("Complaint",style: TextStyle(fontSize: 30,
            // color: Colors.brown,
            // fontWeight: FontWeight.bold,
            //
            // ),
            // ),
            SizedBox(height: 30,width: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: Text("Choose product"),),
                      Expanded(
                        child: DropdownButton(
                          // Initial Value
                          value: dropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Text here',
                      ),
                    ),

                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.centerLeft,
              child:   Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text("choose date",

                        )),
                        Expanded(
                          child: TextField(
                            controller: datecontroller,
                            onTap:() async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100)
                              ) ;
                              if(pickedDate != null){
                                datecontroller.text =
                                    DateFormat ('yyyy-MM-dd').format(pickedDate);
                              }
                            } ,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.date_range),
                                hintText: "Date"
                            ),

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(height: 30),
            SizedBox(height: 30,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => complaint()));
              },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  // padding: EdgeInsets.all(30)
                ),
              ),
            ),

          ]

      ),


    );
  }
}
