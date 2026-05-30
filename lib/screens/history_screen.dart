import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/grocery_provider.dart';
import '../models/cart_model.dart'; // Added this

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = Provider.of<GroceryProvider>(context).history;

    return Scaffold(
      appBar: AppBar(title: const Text('Recent Purchases')),
      body: history.isEmpty
          ? const Center(child: Text('No order history found.'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, i) {
                final order = history[i];
                return ExpansionTile(
                  title: Text('Order #${order.id.substring(order.id.length - 6)}'),
                  subtitle: Text(DateFormat('MMM dd, yyyy • hh:mm a').format(order.date)),
                  trailing: Text('\$${order.total.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  children: order.items.map<Widget>((CartItem item) => ListTile(
                    leading: const Icon(Icons.shopping_basket),
                    title: Text(item.product.name),
                    trailing: Text('x${item.quantity}'),
                  )).toList(),
                );
              },
            ),
    );
  }
}