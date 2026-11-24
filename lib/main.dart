import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products_crud/feature/product/presentation/binding/product_binding.dart';
import 'feature/product/presentation/screens/product_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Product CRUD',

      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),

      initialBinding: ProductBinding(),

      home: const ProductPage(),
    );
  }
}
