import 'package:get/get.dart';
import 'package:responsi/models/product_model.dart';
import 'package:responsi/services/api_services.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();

  final products = <ProductModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _apiService.fetchProducts();
      if (result.isEmpty) {
        errorMessage.value = 'Data kosong atau gagal mem-parsing JSON';
      } else {
        products.value = result;
      }
    } catch (error) {
      errorMessage.value = 'Gagal memuat data: $error';
    } finally {
      isLoading.value = false;
    }
  }
}