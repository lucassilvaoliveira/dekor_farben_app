import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool hidden;

  TextEditingController? controller;

  TextFieldWidget(
      {Key? key, required this.label, required this.icon, this.hidden = false, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(children: [
        Flexible(
          child: TextFormField(
              controller: controller,
              cursorColor: Colors.pink.shade400,
              obscureText: hidden,
              autocorrect: !hidden,
              enableSuggestions: !hidden,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(
                  color: kDefaultTextFieldColor,
                  fontSize: 18,
                ),
                suffixIcon: Icon(
                  icon,
                  color: Colors.grey.shade400,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kDefaultPrimaryColor
                  ),
                ),
              )),
        )
      ]),
    );
  }
}
