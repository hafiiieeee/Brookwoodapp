class CartModel {
  final String name;
  final int id;
  final int price;
  final String imageUrl;
  final int quantity;
  final int cartStatus;
  bool isFavorite;

  CartModel({
    required this.name,
    required this.id,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    this.isFavorite = false,
    required this.cartStatus,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      name: json['p_name'],
      price:int.parse( json['total_price']),
      imageUrl: json['image'],
      quantity: int.parse(json['quantity']),
      cartStatus: int.parse(json['cart_status']),

    );
  }
}

