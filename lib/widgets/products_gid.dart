import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    // here we do not set listen = false, because in the grid we want to update every time there is some change.
    final loadedProducts =
        showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      // we should use this .value approach here rather than builder approach
      // bracause it will helpin loading the items even when they go beyond
      //screen boundries while loading more products
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (c) => loadedProducts[i],
        value: loadedProducts[i],
        child: ProductItem(
            // loadedProducts[i].id,
            // loadedProducts[i].title,
            // loadedProducts[i].imageUrl,
            ),
      ),
      itemCount: loadedProducts.length,
    );
  }
}
