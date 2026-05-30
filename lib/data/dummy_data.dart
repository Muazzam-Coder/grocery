import '../models/product_model.dart';

class DummyData {
  static List<Product> products = [
    // Fruits
    Product(
      id: 'p1',
      name: 'Red Apples',
      price: 2.99,
      category: 'Fruits',
      imageUrl: 'assets/images/apple.svg'
    ),
    Product(
      id: 'p2',
      name: 'Fresh Bananas',
      price: 1.20,
      category: 'Fruits',
      imageUrl: 'assets/images/banana.svg'
    ),
    // Vegetables
    Product(
      id: 'p3',
      name: 'Green Broccoli',
      price: 1.50,
      category: 'Vegetables',
      imageUrl: 'assets/images/broccoli.svg'
    ),
    Product(
      id: 'p4',
      name: 'Organic Carrots',
      price: 0.99,
      category: 'Vegetables',
      imageUrl: 'assets/images/carrots.svg'
    ),
    // Dairy
    Product(
      id: 'p5',
      name: 'Fresh Milk',
      price: 3.50,
      category: 'Dairy',
      imageUrl: 'assets/images/milk.svg'
    ),
    Product(
      id: 'p6',
      name: 'Cheddar Cheese',
      price: 5.20,
      category: 'Dairy',
      imageUrl: 'assets/images/cheese.svg'
    ),
    // Bakery
    Product(
      id: 'p7',
      name: 'Fresh Bagel',
      price: 1.10,
      category: 'Bakery',
      imageUrl: 'assets/images/bagel.svg'
    ),
    Product(
      id: 'p8',
      name: 'Whole Wheat Bread',
      price: 2.80,
      category: 'Bakery',
      imageUrl: 'assets/images/bread.svg'
    ),
  ];

  static List<String> categories = ['All', 'Fruits', 'Vegetables', 'Dairy', 'Bakery'];
}