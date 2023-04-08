import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_4_shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;

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

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var url = Uri.https(
      'shopapp-cd604-default-rtdb.firebaseio.com',
      '/products.json',
    );
    http.post(url, body: json.encode({}));
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
