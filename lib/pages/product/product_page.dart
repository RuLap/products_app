import 'package:flutter/material.dart';

import '../../pages/product/status_line.dart';
import '../../design/colors.dart';
import '../../design/dimensions.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products', style: TextStyle(
          color: secondaryColor,
          fontSize: fontSize24,
          fontWeight: FontWeight.w500
        )),
        centerTitle: true,
        elevation: elevation0
      ),
      body: Column(children: [
        const StatusLine(),
        Container(color: backgroundColor)
      ])
    );
  }
}