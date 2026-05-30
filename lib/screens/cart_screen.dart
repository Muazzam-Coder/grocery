import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grocery_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GroceryProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: provider.cart.isEmpty
          ? const Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.cart.length,
                    itemBuilder: (context, i) {
                      final item = provider.cart[i];
                      return ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(item.product.imageUrl)),
                        title: Text(item.product.name),
                        subtitle: Text('Qty: ${item.quantity} × \$${item.product.price}'),
                        trailing: Text('\$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: \$${provider.cartTotal.toStringAsFixed(2)}', 
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                        onPressed: () {
                          provider.checkout();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order Placed Successfully!'))
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                        child: const Text('Checkout Now'),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}