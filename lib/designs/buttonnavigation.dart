import 'package:brookwoodapp/designs/Account_page.dart';
import 'package:brookwoodapp/designs/homepage.dart';
import 'package:brookwoodapp/user/cart.dart';
import 'package:brookwoodapp/user/democt.dart';
import 'package:brookwoodapp/user/product.dart';
import 'package:flutter/material.dart';

class navigation extends StatefulWidget {
  const navigation({Key? key}) : super(key: key);

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigatioPageName.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,color: Colors.black,),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
    int _selectedIndex = 0;
    List navigatioPageName = [
      home(),
      product(),
      Account_page(),
      Cart(),

    ];
    void onItemTapped(int index){
      setState(() {
        _selectedIndex = index;
      });

  }
}
