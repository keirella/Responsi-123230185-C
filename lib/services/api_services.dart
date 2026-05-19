import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:responsi/models/product_model.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonfakery.com/games/paginated';

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil data produk');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final products = data['products'] as List<dynamic>;

    return products
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}