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
      products.value = await _apiService.fetchProducts();
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
