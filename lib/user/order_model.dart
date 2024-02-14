
class OrderModel {
  int oid;
  int quantity;
  int price;
  String image;
  String name;

  OrderModel(
      {required this.oid,
      required this.name,
      required this.quantity,
      required this.price,
      required this.image});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      oid: json['id'],
      name: json['product_name'],
      quantity:json['quantity'],
      price:json['total_price'],
      image: json['image'],
    );
  }

}
