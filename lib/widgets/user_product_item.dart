import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductItem({
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {},
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
