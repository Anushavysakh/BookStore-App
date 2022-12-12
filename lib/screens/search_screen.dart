import 'package:book_store_app/screens/book_detail_screen.dart';
import 'package:book_store_app/widgets/app_drawer.dart';
import 'package:book_store_app/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/book.dart';
import '../providers/books.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchTitle = '';
  List<Book> filteredList = [];
  List<Book> book = [];

  @override
  Widget build(BuildContext context) {
    final searchBook = Provider.of<Books>(context);
    book = searchBook.items;
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.purple.shade100,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          title: TextField(
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                hintText: 'Search...'),
            onChanged: (textEntered) {
              filteredList =
                  book.where((e) => e.title.contains(textEntered)).toList();
              setState(() {});
            },
          ),
        ),
        body: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final bookFound = filteredList[index];
              return Padding(padding: EdgeInsets.all(10),
                child: ListTile(tileColor: Colors.purple.shade100,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only( bottomRight: Radius.circular(10),topRight: Radius.circular(10))),
                  title: GestureDetector(
                    child: Text(bookFound.title ?? ""),
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(BookDetailScreen.routeName, arguments: bookFound.id),
                  ),
                ),
              );
            }));
  }
}
