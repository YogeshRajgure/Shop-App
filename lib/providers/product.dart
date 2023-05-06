import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus(String authToken, String userId) async {
    final old_status = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final Map<String, String> _queryParam = <String, String>{'auth': authToken};
    final url = Uri.https(
      'shopapp-cd604-default-rtdb.firebaseio.com',
      '/userFavourites/$userId/$id.json',
      _queryParam,
    );
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavourite,
        ),
      );
      if (response.statusCode >= 400) {
        // isFavourite = old_status;
        // notifyListeners();
        _setFavValue(old_status);
      }
    } catch (error) {
      // isFavourite = old_status;
      // notifyListeners();
      _setFavValue(old_status);
    }
  }
}
