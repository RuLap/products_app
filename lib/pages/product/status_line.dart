import 'package:flutter/material.dart';
import 'package:products_app/design/colors.dart';

class StatusLine extends StatelessWidget {
  const StatusLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      Icon(
        Icons.lens,
        color: connectedColor),
      Text("Connected")
    ]);
  }
}