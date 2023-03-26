import 'package:flutter/material.dart';
import 'package:flutter_project_4_shop_app/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _oreders = [];

  List<OrderItem> get orders {
    return [..._oreders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _oreders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    ); // we can also use .add(), but it will add new item at last
    notifyListeners();
  }
}
