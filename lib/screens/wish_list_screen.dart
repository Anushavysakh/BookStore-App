import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/books.dart';
import '../widgets/book_item.dart';
import '../widgets/books_grid.dart';

class WishList extends StatefulWidget {
  static const routeName = '/wishlist-screen';

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  bool _wishlist = true;

  @override
  Widget build(BuildContext context) {
    final booksData = Provider.of<Books>(context);
    final favBooks = booksData.favItems;
    return Scaffold(
      backgroundColor: Colors.purple.shade200,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
        ),

        title: Text('Your Wishlist..'),
        backgroundColor: Colors.purple.shade200,
      ),
      body: BooksGrid(_wishlist),
    );
  }
}
