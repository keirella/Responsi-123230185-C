import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsi/controllers/cart_controller.dart';
import 'package:responsi/models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.image_url,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 70),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ID: ${item.id}',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Released: ${item.released}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.teal),
                  onPressed: () => cartController.updateQuantity(item, item.quantity - 1),
                ),
                Text(
                  '${item.quantity}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Colors.teal),
                  onPressed: () => cartController.updateQuantity(item, item.quantity + 1),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => cartController.removeItem(item.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}