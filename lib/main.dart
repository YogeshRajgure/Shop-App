import 'package:flutter/material.dart';
import 'package:flutter_project_4_shop_app/providers/auth.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/orders.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
              auth.token.toString(),
              auth.userId.toString(),
              previousProducts == null ? [] : previousProducts.items),
          create: (context) => Products(
            Provider.of<Auth>(context, listen: false).token.toString(),
            Provider.of<Auth>(context, listen: false).userId.toString(),
            [],
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(auth.token.toString(),
              previousOrders == null ? [] : previousOrders.orders),
          create: (context) => Orders(
            Provider.of<Auth>(context, listen: false).token.toString(),
            [],
          ),
        )
        // or you can do this for both above
        // ChangeNotifierProvider.value(
        //   value: Cart(),
        // ),
      ],
      child: Consumer<Auth>(
        // we did this due to login page
        builder: (ctx, auth, childd) {
          print("Builder token ${auth.isAuth}");
          print("Builder token ${auth.token}");
          return MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.purple,
              ).copyWith(
                secondary: Colors.deepOrange,
              ),
            ),
            home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              ProductsOverviewScreen.routeName: (ctx) =>
                  ProductsOverviewScreen(),
              ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
              CartScreen.routeNmae: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (cts) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MyShopApp'),
//       ),
//       body: Center(
//         child: Text("lets build this app"),
//       ),
//     );
//   }
// }
