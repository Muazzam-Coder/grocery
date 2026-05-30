import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grocery_provider.dart';
import '../widgets/receipt_popup.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GroceryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: provider.cart.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_basket_outlined, size: 100, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Your cart is empty', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.cart.length,
                    itemBuilder: (context, i) {
                      final item = provider.cart[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              // 1. Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item.product.imageUrl,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15),
                              // 2. Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.product.name, 
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text('\Rs. ${item.product.price.toStringAsFixed(2)}', 
                                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              // 3. Controls (Minus / Qty / Plus)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => provider.updateQuantity(item.product.id, false),
                                        icon: const Icon(Icons.remove_circle_outline, color: Colors.orange),
                                      ),
                                      Text('${item.quantity}', 
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      IconButton(
                                        onPressed: () => provider.updateQuantity(item.product.id, true),
                                        icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  TextButton.icon(
                                    onPressed: () => provider.removeFromCart(item.product.id),
                                    icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                                    label: const Text('Remove', style: TextStyle(color: Colors.red, fontSize: 12)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Summary Bottom Bar
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Total Price:', style: TextStyle(color: Colors.grey)),
                          Text('\Rs. ${provider.cartTotal.toStringAsFixed(2)}', 
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          provider.checkout();
                          final order = provider.history.isNotEmpty ? provider.history.first : null;
                          if (order != null) {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: 'Receipt',
                              barrierColor: Colors.black26,
                              transitionDuration: const Duration(milliseconds: 360),
                              pageBuilder: (context, a1, a2) {
                                return ReceiptPopup(order: order);
                              },
                              transitionBuilder: (context, animation, secondaryAnimation, child) {
                                final curved = Curves.easeOut.transform(animation.value);
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween(begin: const Offset(0, -0.06), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
                                    child: ScaleTransition(scale: Tween(begin: 0.98, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)), child: child),
                                  ),
                                );
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Order placed successfully!'))
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, 
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Checkout', style: TextStyle(fontSize: 18)),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}