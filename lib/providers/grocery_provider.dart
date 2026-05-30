import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../data/dummy_data.dart';
import '../services/storage_service.dart';

class GroceryProvider with ChangeNotifier {
  List<CartItem> _cart = [];
  List<Order> _history = [];
  String _selectedCategory = 'All';

  List<CartItem> get cart => _cart;
  List<Order> get history => _history;
  String get selectedCategory => _selectedCategory;

  List<Product> get filteredProducts {
    if (_selectedCategory == 'All') return DummyData.products;
    return DummyData.products.where((p) => p.category == _selectedCategory).toList();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void addToCart(Product product) {
    int index = _cart.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _cart[index].quantity++;
    } else {
      _cart.add(CartItem(product: product));
    }
    _saveCart();
    notifyListeners();
  }

  double get cartTotal => _cart.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  void checkout() {
    if (_cart.isEmpty) return;
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      items: List.from(_cart),
      total: cartTotal,
    );
    _history.insert(0, order);
    _cart.clear();
    _saveCart();
    _saveHistory();
    notifyListeners();
  }

  // Persistence
  Future<void> _saveCart() async => StorageService.saveData('cart', _cart.map((e) => e.toJson()).toList());
  Future<void> _saveHistory() async => StorageService.saveData('history', _history.map((e) => e.toJson()).toList());

  Future<void> loadData() async {
    final cartData = await StorageService.loadData('cart');
    if (cartData != null) {
      final List decoded = jsonDecode(cartData);
      _cart = decoded.map((item) => CartItem(
        product: DummyData.products.firstWhere((p) => p.id == item['id']),
        quantity: item['qty']
      )).toList();
    }
    
    final historyData = await StorageService.loadData('history');
    if (historyData != null) {
      final List decoded = jsonDecode(historyData);
      _history = decoded.map((item) => Order(
        id: item['id'],
        date: DateTime.parse(item['date']),
        total: item['total'],
        items: (item['items'] as List).map((i) => CartItem(
          product: DummyData.products.firstWhere((p) => p.id == i['id']),
          quantity: i['qty']
        )).toList(),
      )).toList();
    }
    notifyListeners();
  }
}