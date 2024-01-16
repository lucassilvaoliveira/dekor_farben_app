import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import 'default_alert_dialog.dart';

void onSuccessDialog({
  required final BuildContext aContext,
    required final String aTitle,
    required final String aSubtitle,
    required final Function onOkPressed
}) {
  defaultAlertDialog(
      aContext: aContext,
      anImage: SvgPicture.asset(
        "assets/images/success_icon.svg",
        width: 72,
      ),
      aTitle: aTitle,
      aSubtitle: aSubtitle,
      onOkPressed: () => onOkPressed,
      aColor: kDefaultPrimaryColor);
}
