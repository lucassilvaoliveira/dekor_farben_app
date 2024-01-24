import 'package:dekor_farben_app/blocs/invoice/invoice_bloc.dart';
import 'package:dekor_farben_app/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/view/invoice_screen_body.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InvoiceBloc>(
          create: (context) => InvoiceBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: const Scaffold(
        body: InvoiceScreenBody(),
      ),
    );
  }
}
