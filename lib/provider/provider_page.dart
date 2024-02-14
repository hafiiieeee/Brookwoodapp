import 'package:flutter/cupertino.dart';

class Provider_class extends ChangeNotifier {
  List _favImg = [];
  List _favName = [];
  List _favPrice = [];
  int _quantity = 1;

  int get quantity => _quantity;
  List get favoriteImg => _favImg;
  List get favoriteName => _favName;
  List get favoritePrice => _favPrice;


  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void favorites(String img, String name, String price) {
    final favNameList = _favName.contains(name);
    if (favNameList) {
      _favImg.remove(img);
      _favName.remove(name);
      _favPrice.remove(price);
    } else {
      _favImg.add(img);
      _favName.add(name);
      _favPrice.add(price);
    }
    notifyListeners();
  }

  bool icn_change(String icname) {
    final favIcn = _favName.contains(icname);
    return favIcn;
  }
}
