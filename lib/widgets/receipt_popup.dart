import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/order_model.dart';

class ReceiptPopup extends StatelessWidget {
  final Order order;

  const ReceiptPopup({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width > 500 ? 420.0 : width * 0.92;

    return Padding(
      padding: const EdgeInsets.only(top: 40.0, right: 16.0, left: 16.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                width: cardWidth,
                constraints: const BoxConstraints(maxHeight: 520),
                decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 18)],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.receipt_long, color: Colors.green),
                          const SizedBox(width: 8),
                          const Expanded(
                              child: Text('Receipt', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                          Text(order.date.toLocal().toString().split('.').first, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      const Divider(height: 16),
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: order.items.length,
                          separatorBuilder: (_, __) => const Divider(height: 12),
                          itemBuilder: (context, i) {
                            final it = order.items[i];
                            final subtotal = it.product.price * it.quantity;
                            return Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(it.product.imageUrl, width: 46, height: 46, fit: BoxFit.cover),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(it.product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 4),
                                      Text('Qty ${it.quantity}  •  Rs. ${it.product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                Text('Rs. ${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            );
                          },
                        ),
                      ),
                      const Divider(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('Rs. ${order.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).popUntil((r) => r.isFirst);
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              child: const Text('Keep Shopping'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Close'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
