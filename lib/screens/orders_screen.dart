import 'package:flutter/material.dart';
import 'package:flutter_project_4_shop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (cts, i) => OrderItemm(order: orderData.orders[i]),
        itemCount: orderData.orders.length,
      ),
    );
    // orders screen
  }
}
