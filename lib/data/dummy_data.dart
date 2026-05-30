import '../models/product_model.dart';

class DummyData {
  static List<Product> products = [
    // Fruits
    Product(
      id: 'p1', 
      name: 'Red Apples', 
      price: 200, 
      category: 'Fruits', 
      imageUrl: 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=400'
    ),
    Product(
      id: 'p2', 
      name: 'Fresh Bananas', 
      price: 150, 
      category: 'Fruits', 
      imageUrl: 'https://images.unsplash.com/photo-1481349518771-20055b2a7b24?w=400'
    ),
    // Vegetables
    Product(
      id: 'p3', 
      name: 'Green Broccoli', 
      price: 170, 
      category: 'Vegetables', 
      imageUrl: 'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400'
    ),
    Product(
      id: 'p4', 
      name: 'Organic Carrots', 
      price: 100, 
      category: 'Vegetables', 
      imageUrl: 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    ),
    // Dairy
    Product(
      id: 'p5', 
      name: 'Fresh Milk', 
      price: 250, 
      category: 'Dairy', 
      imageUrl: 'https://images.unsplash.com/photo-1523473827533-2a64d0d36748?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    ),
    Product(
      id: 'p6', 
      name: 'Cheddar Cheese', 
      price: 400, 
      category: 'Dairy', 
      imageUrl: 'https://images.unsplash.com/photo-1683314573422-649a3c6ad784?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    ),
    // Bakery
    Product(
      id: 'p7', 
      name: 'Fresh Bagels', 
      price: 350, 
      category: 'Bakery', 
      imageUrl: 'https://images.unsplash.com/photo-1610735458851-bf3be7078588?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    ),
    Product(
      id: 'p8', 
      name: 'Whole Wheat Bread', 
      price: 200, 
      category: 'Bakery', 
      imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400'
    ),
  ];

  static List<String> categories = ['All', 'Fruits', 'Vegetables', 'Dairy', 'Bakery'];
}