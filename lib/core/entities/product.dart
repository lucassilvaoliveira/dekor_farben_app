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
      id: map['productId'] != null ? map['productId'] as String : "undefined",
      companyId: map['companyId'] != null ? map['companyId'] as String : "undefined",
      productPrice: map['productPrice'] != null ? map['productPrice'] as double : 0,
      productDescription: map['productDescription'] != null ? map['productDescription'] as String : "undefined",
      productImagePath: map['productImagePath'] != null ? map['productImagePath'] as String : null,
      productAmount: map['productAmount'] != null ? map['productAmount'] as int : 0,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
