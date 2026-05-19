import 'package:get/get.dart';
import 'package:responsi/controllers/auth_controller.dart';
import 'package:responsi/models/cart_item_model.dart';
import 'package:responsi/models/product_model.dart';
import 'package:responsi/services/cart_services.dart';
import 'package:responsi/pages/main_page.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();
  final AuthController _authController = Get.find<AuthController>();

  final items = <CartItemModel>[].obs;

  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    items.value = _cartService.getItemsByUsername(_authController.username.value);
  }

  Future<void> addToCart(ProductModel product, int quantity) async {
    await _cartService.addToCart(
      username: _authController.username.value,
      product: product,
      quantity: quantity,
    );
    loadCart();
    Get.offAll(() => const MainPage());
    Get.snackbar(
      'Berhasil',
      '${product.name} ditambahkan ke cart.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> updateQuantity(CartItemModel item, int newQuantity) async {
    if (newQuantity < 1) {
      await removeItem(item.id);
      return;
    }
    item.quantity = newQuantity;
    await item.save();
    loadCart();
  }

  Future<void> removeItem(String productId) async {
    await _cartService.removeItem(_authController.username.value, productId);
    loadCart();
  }
}