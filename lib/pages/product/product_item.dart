// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../design/colors.dart';
import '../../design/images.dart';
import '../../domain/product.dart';
import '../../design/dimensions.dart';
import '../../application/product_service.dart';

class ProductItem extends StatelessWidget {
  final ProductService productService;
  final Product product;

  const ProductItem({super.key, required this.product, required this.productService});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height128,
      child: Card(
        color: surfaceColor,
        margin: EdgeInsets.zero,
        elevation: elevation006,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius8)),
        child: Row(
          children: [
            _image(),
            _info(),
            _price()             
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
                width: width80,
                height: height80,);
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

  Widget _info() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: padding10, right: padding10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,      
          children: [
            _name(),           
            _condition(),
            _pickupPoint()
          ]
        )
      )
    );
  }

  Widget _name() {
    return Text(product.name,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: primaryColor,
        fontSize: fontSize16,
        fontWeight: FontWeight.w600
      )
    );
  }

  Widget _description() {
    return Flexible(
      fit: FlexFit.loose,
      child: Text(product.description,
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: secondaryVariantColor,
          fontSize: fontSize12,
          fontWeight: FontWeight.w400
        )
      )
    );
  }

  Widget _condition() {
    return Flexible(
      fit: FlexFit.loose,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(                    
            fontSize: fontSize12,
          ),
          children: <TextSpan>[
            const TextSpan(
              text: 'Состояние: ',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600
              )
            ),
            TextSpan(
              text: product.condition,
              style: const TextStyle(
                color: secondaryVariantColor,
                fontWeight: FontWeight.w400
              )
            )
          ]
        )
      )
    );
  }

  Widget _pickupPoint() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(                  
          fontSize: fontSize12,
        ),
        children: <TextSpan>[
          const TextSpan(text: 'В наличии:\n',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600
            )
          ),
          TextSpan(text: product.pickupPoint,
            style: const TextStyle(
              color: secondaryVariantColor,
              fontWeight: FontWeight.w400
            )
          )
        ]
      )
    );
  }

  Widget _price() {
    NumberFormat formatter = NumberFormat.decimalPattern('ru_RU');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(padding10),
          child: Text("${formatter.format(product.price)}₽",
            style: const TextStyle(
              color: primaryColor,
              fontSize: fontSize18,
              fontWeight: FontWeight.w600
            )
          )
        )
      ]
    );
  }
}