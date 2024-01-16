import 'package:dekor_farben_app/global/widgets/dialogs/default_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

void onErrorDialog({
  required final BuildContext aContext,
  required final String aTitle,
  required final String aSubtitle,
  required final Function onOkPressed
}) {
  defaultAlertDialog(
      aContext: aContext,
      anImage: SvgPicture.asset(
        "assets/images/alert_icon.svg",
        width: 72,
      ),
      aTitle: aTitle,
      aSubtitle: aSubtitle,
      onOkPressed: () => onOkPressed,
      aColor: const Color(0xffEC5B5B)
  );
}