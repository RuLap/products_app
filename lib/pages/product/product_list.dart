import 'package:flutter/material.dart';

import '../../design/dimensions.dart';
import '../../pages/product/product_item.dart';
import '../../application/product_service.dart';
import '../../design/widgets/accent_button.dart';

class ProductList extends StatelessWidget {
  late final ProductService productService;

  ProductList({super.key}) {
      productService = const ProductService();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _list(context),
        Align(
          alignment: Alignment.bottomCenter,
          child: _updateButton()
        )
      ]
    );
  }

  Widget _list(BuildContext context) {
    final safeBottomPadding = MediaQuery.of(context).padding.bottom;
    final bottomPadding = (safeBottomPadding + height45) * 2 + height45;

    return FutureBuilder(
      future: productService.getProducts(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            padding: EdgeInsets.only(
              left: padding16,
              top: padding16,
              right: padding16,
              bottom: bottomPadding
            ),
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: padding16),
        child: AccentButton(title: "Load", onClick: () {})
      )
    );
  }
}