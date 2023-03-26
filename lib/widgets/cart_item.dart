import 'package:flutter/material.dart';
import 'package:flutter_project_4_shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemm extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItemm(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailsScreen.routeName,
            arguments: productId,
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                // minRadius: 15,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(child: Text('\$ $price'))),
              ),
              title: Text(title),
              subtitle: Text('Total: \$${price * quantity}'),
              trailing: Text('x $quantity'),
            ),
          ),
        ),
      ),
    );
  }
}
