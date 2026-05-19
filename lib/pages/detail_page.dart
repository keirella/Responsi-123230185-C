import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsi/controllers/cart_controller.dart';
import 'package:responsi/models/product_model.dart';

class DetailPage extends StatefulWidget {
  final ProductModel product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1;

  void _increaseQuantity() {
    if (_quantity >= widget.product.tba) return;
    setState(() => _quantity++);
  }

  void _decreaseQuantity() {
    if (_quantity <= 1) return;
    setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Image.network(
                product.background_images as String,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const ColoredBox(
                  color: Color(0xFFE0E0E0),
                  child: Icon(Icons.image_not_supported_outlined, size: 48),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            product.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${product.tba.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.teal,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoChip(icon: Icons.new_releases_outlined, label: product.released),
              _InfoChip(icon: Icons.inventory_2_outlined, label: 'tba ${product.tba}'),
              _InfoChip(icon: Icons.star_outline, label: 'Rating ${product.rating}'),
              _InfoChip(icon: Icons.update_outlined, label: 'Update at ${product.update_at}%'),
              _InfoChip(icon: Icons.reviews_outlined, label: 'Review ${product.review_count}%'),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Text('Quantity'),
              const Spacer(),
              IconButton.filledTonal(
                onPressed: _decreaseQuantity,
                icon: const Icon(Icons.remove),
              ),
              SizedBox(
                width: 48,
                child: Text(
                  '$_quantity',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton.filledTonal(
                onPressed: _increaseQuantity,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: product.tba == 0
                ? null
                : () => cartController.addToCart(product, _quantity),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
