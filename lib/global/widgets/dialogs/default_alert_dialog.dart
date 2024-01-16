import 'package:flutter/material.dart';

void defaultAlertDialog({
  required final BuildContext aContext,
  required final Widget anImage,
  required final String aTitle,
  required final String aSubtitle,
  required final Color aColor,
  required final Function onOkPressed
}) {
  showDialog(
    barrierDismissible: false,
    context: aContext,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          margin: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: const Color(0xff2A303E),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      aColor, BlendMode.srcIn),
                  child: anImage),
              const SizedBox(
                height: 24,
              ),
              Text(
                aTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 25, color: aColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                aSubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white, fontSize: 17),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: onOkPressed(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5BEC84),
                        foregroundColor: const Color(0xff2A303E),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 32),
                      ),
                      child: const Text('OK'))
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
