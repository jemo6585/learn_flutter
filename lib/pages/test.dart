import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  List<Product> _products = [
    Product(id: 1, name: 'Red Wine', price: 25.0),
    Product(id: 2, name: 'White Wine', price: 30.0),
    Product(id: 3, name: 'Whiskey', price: 50.0),
    Product(id: 4, name: 'Rum', price: 40.0),
  ];
  List<CartItem> _cartItems = [];
  var total = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Screen'),
      ),
      body: Row(
        children: [
          Expanded(
            child: _buildProductsPage(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _buildCartPage(),
          ),
        ],
      ),
    );

  }
  Widget _buildCartPage() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _cartItems.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text('${_cartItems[index].quantity}x'),
                title: Text(_cartItems[index].product.name),
                subtitle: Text('\$${_cartItems[index].totalPrice.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    setState(() {
                      _removeFromCart(_cartItems[index]);
                    });
                  },
                ),
              );
            },
          ),
        ),
        ListTile(
          title: const Text('Total'),
          trailing: Text('\$${total.toString()}'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Clear Cart'),
              onPressed: () {
                setState(() {
                  _clearCart();
                });
              },
            ),
            ElevatedButton(
              child: const Text('Checkout'),
              onPressed: () {
                // Implementation of checkout method (not shown)
              },
            ),
          ],
        ),
      ],
    );
  }
  void _clearCart() {
    _cartItems.clear();
  }

  void _cartTotal() {
    double _total = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      _total += _cartItems[i].totalPrice;
    }
    setState(() {
      total = _total;
    });
  }
  void _addToCart(Product product) {
    // Check if the product is already in the cart
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].product.id == product.id) {
        // If the product is already in the cart, increment the quantity
        _cartItems[i].quantity++;
        return;
      }
    }

    // If the product is not already in the cart, add a new CartItem to the list
    _cartItems.add(CartItem(product: product));
  }
  void _removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
  }

  Widget _buildProductsPage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Products',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _addToCart(_products[index]);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _products[index].name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${_products[index].price.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}




class Product {
  final int id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}



class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

