import 'package:flutter/material.dart';

import '../../design/dimensions.dart';
import '../../pages/product/product_item.dart';
import '../../application/product_service.dart';

class ProductList extends StatelessWidget {
  late final ProductService productService;

  ProductList({super.key}) {
      productService = const ProductService();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _list(),
        _updateButton()
      ]
    );
  }

  Widget _list() {
    return FutureBuilder(
      future: productService.getProducts(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            padding: const EdgeInsets.only(left: padding16, top: padding16, right: padding16),
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: height8);
            },
            itemBuilder: (BuildContext context, int index) {
              return ProductItem(product: snapshot.data![index]);
            },
          );
        }
        else if(snapshot.hasError) {
          return const Text("ERROR");
        }
        else {
          return const Text("None");
        }
      },
    );
  }

  Widget _updateButton() {
    return Container();
  }
}