import 'package:flutter/material.dart';
import 'package:products_app/application/product_service.dart';

import '../../design/colors.dart';
import '../../design/dimensions.dart';
import '../../design/widgets/status_line.dart';
import '../../pages/product/product_list.dart';

class ProductPage extends StatelessWidget {
  late final ProductService productService;
  
  ProductPage({super.key}) {
    productService = const ProductService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Товары',
          style: TextStyle(
            color: secondaryColor,
            fontSize: fontSize24,
            fontWeight: FontWeight.w500
          )
        ),
        centerTitle: true,
        elevation: elevation0
      ),
      body: Column(children: [
        const StatusLine(),
        Flexible(
          child: Container(
            color: backgroundColor,
            child: ProductList(productService: productService)
          ),
        )
      ])
    );
  }
}