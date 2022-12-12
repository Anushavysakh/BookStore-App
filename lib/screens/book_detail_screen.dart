import 'package:book_store_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/books.dart';

class BookDetailScreen extends StatelessWidget {
  static const routeName = '/book-detail';

  const BookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedBook = Provider.of<Books>(context, listen: false)
        .items
        .firstWhere((prod) => prod.id == bookId);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.purple.shade400,
            title: IconButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(SearchScreen.routeName),
              icon: Icon(Icons.arrow_back),
            )),
        backgroundColor: Colors.purple.shade100,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 400,
              backgroundColor: Colors.purple.shade100,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                    tag: loadedBook.id,
                    child: Image.asset(
                      loadedBook.image,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    )),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 30,
              ),
              Text(
                loadedBook.title,
                style: TextStyle(fontSize: 30, color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${loadedBook.price}',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedBook.author,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              const SizedBox(
                height: 800,
              )
            ])),
          ],
        ));
  }
}
