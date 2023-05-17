class Product {
  String id;
  String companyId;
  double productPrice;
  String productDescription;
  String? productImagePath;
  int productAmount;
  DateTime createdAt;
  DateTime updatedAt;
  
  Product({
    required this.id,
    required this.companyId,
    required this.productPrice,
    required this.productDescription,
    required this.productImagePath,
    required this.productAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['productId'] ?? "undefined",
      companyId: map['companyId'] ?? "undefined",
      productPrice: map['productPrice'] ?? 0,
      productDescription: map['productDescription'] ?? "undefined",
      productImagePath: map['productImagePath'],
      productAmount: map['productAmount'] ?? 0,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
