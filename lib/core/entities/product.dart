import 'dart:typed_data';

class Product {
  String id;
  String companyId;
  double productPrice;
  String productName;
  String productDescription;
  String? productImagePath;
  int productAmount;
  DateTime createdAt;
  DateTime updatedAt;
  Uint8List? image;

  Product({
    required this.id,
    required this.companyId,
    required this.productPrice,
    required this.productName,
    required this.productDescription,
    required this.productImagePath,
    required this.productAmount,
    required this.createdAt,
    required this.updatedAt,
    this.image
  });

  factory Product.  fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? "undefined",
      companyId: map['company_id'] ?? "undefined",
      productPrice: map['price'] ?? 0,
      productDescription: map['description'] ?? "undefined",
      productName: map['name'] ?? "undefined",
      productImagePath: map['productImagePath'],
      productAmount: map['amount'] ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
    );
  }
}
