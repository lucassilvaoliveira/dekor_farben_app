import 'package:dekor_farben_app/blocs/company/company_bloc.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/view/choose_company_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseCompanyScreen extends StatelessWidget {
  const ChooseCompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CompanyBloc(),
      child: const Scaffold(
        body: ChooseCompanyBody(),
      ),
    );
  }
}
