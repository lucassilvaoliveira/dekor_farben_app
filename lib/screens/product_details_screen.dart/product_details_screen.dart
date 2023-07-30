import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/screens/product_details_screen.dart/components/view/product_details_body.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductDetailsBody(product: product),
    );
  }
}
