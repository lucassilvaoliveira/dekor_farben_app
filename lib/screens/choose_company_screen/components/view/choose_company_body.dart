import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/texts.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/widgets/company_widget.dart';
import 'package:flutter/material.dart';

class ChooseCompanyBody extends StatelessWidget {
  const ChooseCompanyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: kDefaultPrimaryColor,
              height: 200,
              width: size.width,
              child: Center(
                child: Container(
                  width: size.width,
                  margin: const EdgeInsets.only(left: 25, top: 50),
                  child: Text(
                    'Selecione a empresa\nque deseja ver hoje',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(top: 155, right: 15),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(1, 1) // changes position of shadow
                        ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.search,
                      size: 25, color: kDefaultPrimaryColor),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 2, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .65,
                  width: size.width,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 0),
                    itemCount: 5,
                    itemBuilder: (_, index) => CompanyWidget(size: size),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
