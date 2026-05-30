import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/grocery_provider.dart';
import '../models/cart_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the history list from our Provider
    final history = Provider.of<GroceryProvider>(context).history;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recent Purchases',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: history.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No order history found',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: history.length,
              itemBuilder: (context, i) {
                final order = history[i];
                
                // Format the date into a readable string (e.g., Oct 24, 2023 • 02:30 PM)
                String formattedDate = DateFormat('MMM dd, yyyy • hh:mm a').format(order.date);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ExpansionTile(
                    shape: const Border(), // Removes the default lines
                    leading: const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                    title: Text(
                      'Order #${order.id.substring(order.id.length - 6)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(formattedDate),
                    trailing: Text(
                      '\Rs. ${order.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                    children: [
                      const Divider(),
                      // List the specific products bought in this order
                      ...order.items.map<Widget>((CartItem item) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              item.product.imageUrl,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => 
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                          title: Text(item.product.name),
                          subtitle: Text('\Rs. ${item.product.price} each'),
                          trailing: Text(
                            'x${item.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
    );
  }
}