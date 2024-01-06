import 'package:dekor_farben_app/blocs/company/company_state.dart';
import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'coins_amount_widget.dart';

class CompanyDescriptionWidget extends StatelessWidget {
  final User user;

  const CompanyDescriptionWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StoreConnector<CompanyGetOneSuccessState, Company>(
        converter: (store) => store.state.company,
        builder: (context, company) {
          return SizedBox(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Esta é a empresa ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 18)),
                      TextSpan(
                          text: company.companyName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold))
                    ])),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                CoinsAmountWidget(amount: user.userPoints ?? 0),
              ],
            ),
          );
        });
  }
}
