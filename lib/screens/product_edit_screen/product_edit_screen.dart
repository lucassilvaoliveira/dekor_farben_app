import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/screens/product_edit_screen/view/product_edit_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/product/product_bloc.dart';

class ProductEditScreen extends StatelessWidget {
  final Product product;

  const ProductEditScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(),
      child: Scaffold(
        body: ProductEditBody(product: product),
      ),
    );
  }
}
