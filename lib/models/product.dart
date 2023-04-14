class PosProduct {
  final int id;
  final String name;
  final String description;
  final double price;

  PosProduct({required this.id, required this.name, required this.description, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory PosProduct.fromMap(Map<String, dynamic> map) {
    return PosProduct(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
    );
  }
}
