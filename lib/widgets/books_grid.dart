import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/book.dart';
import '../providers/books.dart';
import 'book_item.dart';

class BooksGrid extends StatelessWidget {
  final bool showWishlist;


  BooksGrid(this.showWishlist);

  @override
  Widget build(BuildContext context) {
    final booksData = Provider.of<Books>(context);
    final books = showWishlist ? booksData.favItems : booksData.items;
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: books.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1 / 2),
        itemBuilder: (context, index) =>
            ChangeNotifierProvider.value(
              value: books[index],
              child: BookItem(),
            )
        ,
      ),
    );
  }
}
