import 'dart:typed_data';

import 'package:html/parser.dart';

class Product {
  String name;
  String description;
  ProductImage image;
  double price;
  String condition;
  String pickupPoint;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.condition,
    required this.pickupPoint
  });

  factory Product.fromJson(Map<dynamic, dynamic> json) => Product(
    name: json["name"],
    description: removeHtmlTags(json["description"]),
    image: ProductImage.noImage(selectBaseImage(json["images_ids"])),
    price: json["price"].toDouble(),
    condition: json["condition"],
    pickupPoint: json["pickup_point"]
  );

  static String selectBaseImage(List<dynamic> images) {
    for(String image in images) {
      if(image.isNotEmpty) {
        return image;
      }
    }

    return "";
  }

  static String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>",multiLine: true, caseSensitive: true);
    String result = htmlString.replaceAll(exp, '');

    return result;
  }
}

class ProductImage {
  String name;
  Uint8List? bytes;

  ProductImage({
    required this.name,
    this.bytes
  });

  factory ProductImage.noImage(String imageName) => ProductImage(
    name: imageName,
    bytes: null
  );

  void setImage(Uint8List imageBytes) {
    bytes = imageBytes;
  }
}