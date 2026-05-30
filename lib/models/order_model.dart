import 'cart_model.dart';

class Order {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final double total;

  Order({required this.id, required this.date, required this.items, required this.total});

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'total': total,
    'items': items.map((i) => i.toJson()).toList(),
  };
}