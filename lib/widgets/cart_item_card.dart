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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.image_url,
                width: 76,
                height: 76,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 76,
                  height: 76,
                  color: const Color(0xFFE0E0E0),
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text('Qty: ${item.quantity}'),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Hapus',
              onPressed: () => cartController.removeItem(item.id),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}
