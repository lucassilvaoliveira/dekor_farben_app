import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/screens/product_detail_screen/view/product_detail_body.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Campaign campaign;

  const ProductDetailScreen({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductDetailBody(campaign: campaign),
    );
  }
}
