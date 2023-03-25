import 'package:flutter/material.dart';

import '../providers/product.dart';
import '../widgets/products_gid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const routeName = '/';

  // final List<Product> loadedProducts = ;

  // ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}
