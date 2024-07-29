import 'package:flutter/material.dart';

import '../../design/dimensions.dart';
import '../../domain/product.dart';
import '../../pages/product/product_item.dart';
import '../../application/product_service.dart';
import '../../design/widgets/accent_button.dart';

class ProductList extends StatefulWidget{
  final ProductService productService;
  const ProductList({super.key, required this.productService});

  @override
  _ProductList createState() => _ProductList();
}

class _ProductList extends State<ProductList> {
  Future<List<Product>> products = Future(() => []);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _list(),
        Align(
          alignment: Alignment.bottomCenter,
          child: _updateButton()
        )
      ]
    );
  }

  Widget _list() {
    final safeBottomPadding = MediaQuery.of(context).padding.bottom;
    final bottomPadding = (safeBottomPadding + height8) * 2 + height45;

    return FutureBuilder(
      future: products,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              width: width45,
              height: height45,
              child: CircularProgressIndicator()
            )
          );
        }
        else if(snapshot.hasData) {
          return ListView.separated(
            addAutomaticKeepAlives: true,
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
              return ProductItem(product: snapshot.data![index], productService: widget.productService);
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
        child: AccentButton(title: "Загрузить", onClick: _loadProducts)
      )
    );
  }

  void _loadProducts() {
    setState(() {
      products = Future(() => widget.productService.getProducts());
    });
  }
}