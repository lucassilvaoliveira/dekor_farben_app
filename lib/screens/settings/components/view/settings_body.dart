import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/rollback_screen_widget.dart';
import 'package:dekor_farben_app/screens/settings/components/widgets/profile_pic_widget.dart';
import 'package:dekor_farben_app/screens/settings/components/widgets/settings_options_widget.dart';
import 'package:flutter/material.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 2, vertical: kDefaultPadding * 2),
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .1,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      RollbackScreenWidget(
                        onExec: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Configurações",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * .02),
            SizedBox(
              height: size.height * .75,
              width: size.width,
              child: Column(
                children: [
                  const ProfilePicWidget(),
                  SettingsOptionsWidget(size: size)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
