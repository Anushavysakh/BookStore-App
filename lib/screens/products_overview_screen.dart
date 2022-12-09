import 'package:flutter/material.dart';

import '../model/book.dart';
import '../providers/books.dart';
import '../widgets/book_item.dart';

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  List<Book> loadedBooks = [
    Book(
        id: "1",
        image: "assets/book_2.jpg",
        title: "Building Planning",
        author: "S.S.Bhavikatti",
        price: 1400),
    Book(
        id: "2",
        image: "assets/books-2.jpg",
        title: "The Colony",
        author: "Audrey Magee",
        price: 444),
    Book(
        id: "3",
        image: "assets/book-3.jpg",
        title: "Chats with the Dead",
        author: "Shehan Karunatilaka",
        price: 399),
    Book(
        id: "4",
        image: "assets/books-4.jpg",
        title: "Treacle Walker",
        author: "Alan Garner",
        price: 300),
    Book(
        id: "5",
        image: "assets/books-5.jpg",
        title: "Glory",
        author: "Noviolet",
        price: 400),
    Book(
        id: "7",
        image: "assets/books-6.jpg",
        title: "Chinaman",
        author: "Pradeep mathew",
        price: 600),
    Book(
        id: "8",
        image: "assets/books-7.jpg",
        title: "Small Things Like These",
        author: "Claire",
        price: 850),
    Book(
        id: "9",
        image: "assets/books-8.jpg",
        title: "Rohzin",
        author: "Rahman Abbas",
        price: 448),
    Book(
        id: "10",
        image: "assets/books-9.jpg",
        title: "Oh William",
        author: "Elizabeth",
        price: 410),
    Book(
        id: "11",
        image: "assets/books-10.jpg",
        title: "Nights of Plague",
        author: "Orhan pamuk",
        price: 525),
    Book(
        id: "12",
        image: "assets/books-11.jpg",
        title: "The Birth Lottery and Other Surprises",
        author: "Shehan Karunatilaka",
        price: 880),
    Book(
        id: "13",
        image: "assets/books-12.jpg",
        title: "The Trees",
        author: "Percival Everett",
        price: 839),
    Book(
        id: "14",
        image: "assets/books-13.jpg",
        title: "Nightcrawling",
        author: "Leila Mottley",
        price: 690),
    Book(
        id: "15",
        image: "assets/books-14.jpg",
        title: "After Sappho",
        author: "Selby Wynn Schwartz",
        price: 358),
    Book(
        id: "16",
        image: "assets/books-15.jpg",
        title: "Trust",
        author: "Hernan Diaz",
        price: 518)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                foregroundColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
                backgroundColor: Colors.purple.shade400,
              ).copyWith(elevation: MaterialStatePropertyAll(5)),
              onPressed: () {},
              child: Row(
                children: const [
                  Icon(Icons.search),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Search ',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: loadedBooks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 2),
        itemBuilder: (context, index) {
          return BookItem(
            id: loadedBooks[index].id,
            image: loadedBooks[index].image,
            title: loadedBooks[index].title,
            price: loadedBooks[index].price,
          );
        },
      ),
    );
  }
}
