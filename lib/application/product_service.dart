import 'dart:convert';
import 'dart:typed_data';

import '../../domain/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  const ProductService();

  Future<List<Product>> getProducts() async {
    final uri = Uri.parse("http://62.109.21.134:5199/products");
    final response = await http.get(uri);
    final json = jsonDecode(response.body.toString())["result"]["product_list"];

    List<Product> result = [];
    if(response.statusCode == 200) {
      for(Map product in json) {
        result.add(Product.fromJson(product));
      }

      return result;
    }
    else {
      throw Exception('Failed to load product');
    }
  }

  Future<Uint8List> getProductImage(String imageName) async {
    final uri = Uri.parse("http://62.109.21.134:5199/image/${imageName}");
    final response = await http.get(uri);
    final bytes = response.bodyBytes;

    if(bytes.isNotEmpty) {
      if(response.statusCode == 200) {
        return Future.value(bytes);
      }
      else {
        throw Exception('Failed to load product image');
      }
    }
    else {
      return Future.value(response.bodyBytes);
    }
  }
}