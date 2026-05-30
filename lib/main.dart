import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/grocery_provider.dart';
import 'screens/main_wrapper.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GroceryProvider()..loadData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainWrapper(),
      ),
    ),
  );
}