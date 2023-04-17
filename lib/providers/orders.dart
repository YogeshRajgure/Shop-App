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
  final String authToken;

  Orders(this.authToken, this._oreders);

  List<OrderItem> get orders {
    return [..._oreders];
  }

  Future<void> fetchAndSetOrders() async {
    final Map<String, String> _queryParam = <String, String>{'auth': authToken};
    var url = Uri.https(
      'shopapp-cd604-default-rtdb.firebaseio.com',
      '/orders.json',
      _queryParam,
    );
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, OrderData) {
      loadedOrders.add(
        OrderItem(
            id: orderId,
            amount: OrderData['amount'],
            dateTime: DateTime.parse(OrderData['dateTime']),
            products: (OrderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price']))
                .toList()),
      );
    });
    _oreders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final Map<String, String> _queryParam = <String, String>{'auth': authToken};
    var url = Uri.https(
      'shopapp-cd604-default-rtdb.firebaseio.com',
      '/orders.json',
      _queryParam,
    );
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList()
      }),
    );
    _oreders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timeStamp,
      ),
    ); // we can also use .add(), but it will add new item at last
    notifyListeners();
  }
}
