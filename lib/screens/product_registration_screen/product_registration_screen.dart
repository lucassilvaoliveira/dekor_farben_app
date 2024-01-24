import 'package:dekor_farben_app/blocs/product/product_bloc.dart';
import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/screens/product_registration_screen/view/product_registration_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductRegistrationScreen extends StatelessWidget {
  final Campaign campaign;

  const ProductRegistrationScreen({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(),
      child: Scaffold(
        body: ProductRegistrationBody(campaign: campaign),
      ),
    );
  }
}
