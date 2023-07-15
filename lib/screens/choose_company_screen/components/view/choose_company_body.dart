import 'package:dekor_farben_app/global/texts.dart';
import 'package:flutter/material.dart';

class ChooseCompanyBody extends StatelessWidget {
  const ChooseCompanyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: size.height * .25,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selecione a empresa\nque deseja ver hoje',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 30),
                ),
                Text(
                  chooseThemeScreenDescription,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          Container(
            height: size.height * .65,
            width: size.width,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 10,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () => print("testing $index"),
                child: Container(
                  color: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  height: size.height * .20,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/github-logo.png',
                        width: size.width * .25,
                      ),
                      SizedBox(height: 10),
                      Text("  Git Hub"),
                      SizedBox(height: 10),
                      Container(
                        height: 2,
                        width: size.width,
                        color: Colors.black.withOpacity(.3),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
