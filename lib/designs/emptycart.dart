import 'package:flutter/material.dart';

class EmptyCartImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'images/empty.jpg',
        width: 400, // adjust the size to fit your design
        height: 400,
      ),
    );
  }
}
