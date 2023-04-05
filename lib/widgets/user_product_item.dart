import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    final scafflodMessanger_stored = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        // .deleteProduct(id);
                        .showAlertDialog(context, id);
                  } catch (error) {
                    print('caugrtr this error');
                    scafflodMessanger_stored.showSnackBar(
                      const SnackBar(
                        content: Text('Deleting Failed!'),
                      ),
                    );
                  }
                },
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
