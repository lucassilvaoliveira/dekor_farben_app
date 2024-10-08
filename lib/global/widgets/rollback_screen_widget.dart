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
        alignment: Alignment.center,
        height: 35,
        width: 35,
        child: const Icon(Icons.arrow_back, size: 35),
      ),
    );
  }
}