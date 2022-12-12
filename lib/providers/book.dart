import 'package:flutter/cupertino.dart';

class Book with ChangeNotifier{
  final String id;
  final String image;
  final String title;
  final String author;
  final double price;
  bool isWishlist;

  Book(
      {required this.id,
      required this.image,
      required this.title,
      required this.author,
      required this.price,
       this.isWishlist = false});


  void toggleWishList(){
    isWishlist = !isWishlist;
    notifyListeners();
  }
}
