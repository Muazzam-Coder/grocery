import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grocery_provider.dart';
import '../data/dummy_data.dart';
import '../widgets/product_card.dart';     // Added import
import '../widgets/category_chip.dart';    // Added import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to changes in the provider
    final provider = Provider.of<GroceryProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fresh Grocery', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Category Selector using the CategoryChip widget
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              itemCount: DummyData.categories.length,
              itemBuilder: (context, i) {
                final cat = DummyData.categories[i];
                return CategoryChip(
                  label: cat,
                  isSelected: provider.selectedCategory == cat,
                  onSelected: () => provider.setCategory(cat),
                );
              },
            ),
          ),

          // 2. Product Grid using the ProductCard widget
          Expanded(
            child: provider.filteredProducts.isEmpty
                ? const Center(child: Text("No products found in this category"))
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72, // Adjusted for button space
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: provider.filteredProducts.length,
                    itemBuilder: (context, i) {
                      final product = provider.filteredProducts[i];
                      return ProductCard(
                        product: product,
                        onAdd: () {
                          provider.addToCart(product);
                          // Optional: Show a small toast/snackbar when added
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} added to cart!'),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}