import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../designs/model.dart';
import '../provider/provider_page.dart';

class bookshelf extends StatefulWidget {
  const bookshelf({Key? key}) : super(key: key);

  @override
  State<bookshelf> createState() => _bookshelfState();
}

class _bookshelfState extends State<bookshelf> {
  List items = [
    Model(image: "images/bookshelf.jpg", name: "Wake up india",description:"", price: '45000'),
    Model(image: "images/bookshelf2.jpg", name: "Allie wood",description:"", price: '39000'),
    // Model(image: "images/bed3.webp", name: "Vintage home", price: '30000'),
  ];

  @override
  Widget build(BuildContext context) {
    final object = Provider.of<Provider_class>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: Text(
          'bookshelf',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 4 / 5.4,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 142,
                        decoration: BoxDecoration(
                            color: Colors.grey[200]),
                        child: Column(
                          children: [
                            Container(
                              height: 90,
                              child: Stack(
                                children: [
                                  Image(image: AssetImage(items[index].image)),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 70, top: 10),
                                    child: GestureDetector(
                                        onTap: () {
                                          object.favorites(
                                              items[index].image,
                                              items[index].name,
                                              items[index].price);
                                        },
                                        child:object.icn_change(items[index].name)
                                            ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 30
                                        )
                                            : Icon(
                                            Icons.favorite_border,
                                            color: Colors.blue,
                                            size: 30
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(items[index].name),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              items[index].price,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),

                          ],
                        ),
                      );
                    }),
              ),

            ]
        ),
      ),
    );
  }
}






