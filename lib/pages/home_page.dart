import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsi/controllers/auth_controller.dart';
import 'package:responsi/controllers/product_controller.dart';
import 'package:responsi/pages/cart_page.dart';
import 'package:responsi/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final productController = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Halo, ${authController.username.value}')),
        actions: [
          IconButton(
            tooltip: 'Cart',
            onPressed: () => Get.to(() => const CartPage()),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Obx(
        () {
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productController.errorMessage.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      productController.errorMessage.value,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: productController.fetchProducts,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: productController.fetchProducts,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: productController.products.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return ProductCard(product: productController.products[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
