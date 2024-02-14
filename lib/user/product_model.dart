class Product {
  final String name;
  final int id;
  final int price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.name,
    required this.id,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['product_name'],
      price: json['product_price'],
      imageUrl: json['image'],

    );
  }
}
/*

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late List<Product> _products;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse('https://example.com/api/products'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      final products = data.map((json) => Product(
        name: json['name'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl'],
      )).toList();
      setState(() {
        _products = products;
      });
    } else {
      // Handle the case where the server returned an error.
      print('Failed to fetch products. Server returned status code ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: _products == null ? Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            leading: Image.network(product.imageUrl),
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: product.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  product.isFavorite = !product.isFavorite;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
*/
