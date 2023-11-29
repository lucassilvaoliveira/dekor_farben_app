import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../global/widgets/primary_button_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingScreenSate();
}

class _OnboardingScreenSate extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
                height: size.height * 0.47,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SvgPicture.asset(
                          "assets/images/onboarding_circle.svg",
                          width: size.width * .45,
                        ),
                        Container(
                          margin: EdgeInsets.all(size.width * .15),
                          child: Image.asset(
                              'assets/images/decorator-login-image.png'),
                        )
                      ],
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(size.width * .2),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Decor ',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: kDefaultTitleColor,
                            fontSize: 35,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Chivo'),
                      ),
                      TextSpan(
                          text: 'Coins',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: kDefaultTitleColor,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Chivo')),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: size.height * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => {
                      Future.delayed(Duration.zero, () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: true,
                          enableDrag: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(42),
                              topRight: Radius.circular(42),
                            ),
                          ),
                          builder: (_) => const LoginWidget(),
                        );
                      })
                    },
                    child: const PrimaryButtonWidget(text: 'Usuário'),
                  ),
                  const SizedBox(width: 25),
                  GestureDetector(
                      child: const PrimaryButtonWidget(text: 'Empresa'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
