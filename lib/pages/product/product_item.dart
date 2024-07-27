// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../design/colors.dart';
import '../../design/images.dart';
import '../../domain/product.dart';
import '../../design/dimensions.dart';
import '../../application/product_service.dart';

class ProductItem extends StatelessWidget {
  late ProductService productService;
  final Product product;

  ProductItem({super.key, required this.product}) {
    productService = const ProductService();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height128,
      child: Card(
        color: surfaceColor,
        margin: EdgeInsets.zero,
        elevation: elevation006,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius8)),
        child: Row(children: [
          _image(),
          _title()     
        ]),
    ));
  }

  Widget _image() {
    return Padding(
      padding: const EdgeInsets.only(left: padding10, right: padding10),
      child: FutureBuilder(
        future: productService.getProductImage(product.image.name),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }
          else if(snapshot.hasData) {
            product.image.setImage(snapshot.data!);
            try {
              return Image.memory(
                product.image.bytes!,
                width: width100,
                height: height100,);
            }
            catch (e){
              return emptyPicture;
            }
          }
          else if(snapshot.hasError) {
            return emptyPicture;
          }
          else {
            return const SizedBox.shrink();
          }
        },
      )
    );
  }

  Widget _title() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: padding10, right: padding10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,      
          children: [
            Text(product.name,
              style: const TextStyle(
                color: primaryColor,
                fontSize: fontSize16,
                fontWeight: FontWeight.w600
              )
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(product.description,
                  style: const TextStyle(
                  color: primaryColor,
                  fontSize: fontSize12,
                  fontWeight: FontWeight.w400
                )
              )
            )
          ]
        )
      )
    );
  }
}