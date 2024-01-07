import 'package:flutter/material.dart';

class TextBoxWidget extends StatelessWidget {

  final IconData iconProp;
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  final bool? isEditable;

  const TextBoxWidget({
    super.key,
    required this.iconProp,
    required this.text,
    required this.sectionName,
    required this.onPressed,
    this.isEditable
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 6,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(8), color: Colors.white),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: Row(
        children: [
          Icon(
            iconProp,
            size: 30,
            color: Colors.grey[700],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sectionName,
                  style: TextStyle(color: Colors.grey[500]),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: size.width * .4,
                    child: RichText(
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: text,
                        style: const TextStyle(color: Colors.black)
                      )
                    )
                ),
              ],
            ),
          ),
          const Spacer(),
          _isEditable(isEditable, onPressed)
        ],
      ),
    );
  }
}

Widget _isEditable(final bool? isEditable, final Function()? onPressed) {
  if (isEditable != null && isEditable && onPressed != null) {
    return IconButton(
      icon: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
      onPressed: onPressed,
    );
  } else {
    return const SizedBox.shrink();
  }
}