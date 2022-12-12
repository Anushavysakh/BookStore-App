import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/http_exception.dart';
import 'book.dart';

class Books with ChangeNotifier {
  String? authToken;
  String? userId;

  Books(
    this.authToken,
    this._items,
    this.userId,
  );

  List<Book> _items = [];
  var _showFavoritesOnly = false;

  List<Book> get items {
    return [..._items];
  }

  Book findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Book> get favItems {
    return _items.where((bookItem) => bookItem.isWishlist).toList();
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://shopapp-e0d5d-default-rtdb.asia-southeast1.firebasedatabase.app/Books.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return;
      }
      url =
          'https://books-store-607cf-default-rtdb.firebaseio.com/Books/userFavorites/$userId.json.json?auth=$authToken';
      final favoritesResponse = await http.get(Uri.parse(url));
      final favoriteData = json.decode(favoritesResponse.body);
      final List<Book> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Book(
            id: prodId,
            title: prodData['title'],
            author: prodData['author'],
            price: prodData['price'],
            image: prodData['image'],
            isWishlist:
                favoriteData == null ? false : favoriteData[prodId] ?? false));
      });
      _items = loadedProducts;
      //notifyListeners();

    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://books-store-607cf-default-rtdb.firebaseio.com/books/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Book? existingProduct = _items[existingProductIndex];
    try {
      final response = await http.delete(Uri.parse(url));
      _items.removeAt(existingProductIndex);
      notifyListeners();
      if (response.statusCode >= 400) {
        _items.insert(existingProductIndex, existingProduct!);
        notifyListeners();
        throw HttpException('Could not delete product');
      }
      existingProduct = null;

      _items.removeAt(existingProductIndex);
      notifyListeners();
    } catch (error) {
      throw NetException("Something went wrong!!");
    }
  }
}
