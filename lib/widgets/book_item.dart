import 'package:book_store_app/screens/book_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/book.dart';
import '../providers/books.dart';
import '../providers/cart.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key});

  @override
  Widget build(BuildContext context) {
    final book = Provider.of<Book>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRect(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(BookDetailScreen.routeName, arguments: book.id);
        },
        child: Card(
          color: Colors.purple.shade100,
          margin: EdgeInsets.all(2),
          elevation: 100,
          borderOnForeground: true,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<Book>(
                  builder: (context, book, _) =>
                      IconButton(
                          onPressed: () {
                            book.toggleWishList();
                          },
                          icon: Icon(book.isWishlist
                              ? Icons.favorite
                              : Icons.favorite_border)),
                )
              ],
            ),
            Expanded(
              flex: 10,
              child: GridTile(
                child: Image.asset(book.image, fit: BoxFit.scaleDown),
              ),
            ),
            Text(book.title,textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
                book
                .price.toString()),
            ElevatedButton(
                onPressed: () {
                  cart.addItem(book.id, book.price, book.title);
                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                    content: const Text('Added item to cart'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(label: 'UNDO', onPressed: () {
                      cart.removeSingleItem(book.id);
                    },),
                  ));
                },
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                          2,
                        )))),
                    backgroundColor: MaterialStatePropertyAll(Colors.purple)),
                child: const Text(
                  'ADD TO CART',
                  style: TextStyle(fontSize: 8, color: Colors.white),
                )),
            const SizedBox(
              width: 30,
            )
          ]),
        ),
      ),
    );
  }
}
