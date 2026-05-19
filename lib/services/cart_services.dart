import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi/models/cart_item_model.dart';
import 'package:responsi/models/product_model.dart';

class CartService {
  static const String boxName = 'cartBox';

  Box<CartItemModel> get _box => Hive.box<CartItemModel>(boxName);

  List<CartItemModel> getItemsByUsername(String username) {
    return _box.values.where((item) => item.username == username).toList();
  }

  Future<void> addToCart({
    required String username,
    required ProductModel product,
    required int quantity,
  }) async {
    final key = _key(username, product.id);
    final existingItem = _box.get(key);

    if (existingItem == null) {
      await _box.put(
        key,
        CartItemModel(
          username: username,
          id: product.id,
          name: product.name,
          released: product.released,
          rating: product.rating,
          quantity: quantity,  
          image_url: '',
        ),
      );
      return;
    }

    existingItem.quantity =
        (existingItem.quantity + quantity).clamp(1, product.tba).toInt();
    await existingItem.save();
  }

  Future<void> removeItem(String username, int productId) async {
    await _box.delete(_key(username, productId));
  }

  String _key(String username, int productId) => '$username-$productId';
}
