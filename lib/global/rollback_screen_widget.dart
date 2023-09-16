import 'package:flutter/material.dart';

class RollbackScreenWidget extends StatelessWidget {
  final Function() onExec;
  const RollbackScreenWidget({
    super.key,
    required this.onExec
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onExec,
      child: Container(
        height: 25,
        width: 25,
        color: Colors.transparent,
        child: const Icon(Icons.arrow_back_ios),
      ),
    );
  }
}