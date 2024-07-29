import 'package:flutter/material.dart';

import '../../design/colors.dart';
import '../../pages/product/product_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Products",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: primaryColor
        )
      ),
      home: Scaffold(
        body: Center(
          child: ProductPage(),
        ),
      ),
    );
  }
}
