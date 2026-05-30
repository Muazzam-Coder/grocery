import 'package:flutter/material.dart';
import '../models/order_model.dart';

class ReceiptScreen extends StatelessWidget {
  final Order order;

  const ReceiptScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 6),
            Text('Date: ${order.date.toLocal()}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const Divider(height: 24),
            const Text('Items', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: order.items.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, i) {
                  final it = order.items[i];
                  final subtotal = it.product.price * it.quantity;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(it.product.imageUrl, fit: BoxFit.cover),
                    ),
                    title: Text(it.product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Qty: ${it.quantity}  •  Rs. ${it.product.price.toStringAsFixed(2)}'),
                    trailing: Text('Rs. ${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                },
              ),
            ),
            const Divider(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Rs. ${order.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Keep Shopping'),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('Close'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
