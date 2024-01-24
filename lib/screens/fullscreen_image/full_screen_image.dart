import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class FullScreenImage extends StatelessWidget {
  final Uint8List image;

  const FullScreenImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: MemoryImage(image),
            fit: BoxFit.cover
        ) ,
      ),
    );
  }
}