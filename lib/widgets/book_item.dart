import 'package:book_store_app/screens/book_detail_screen.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final String id;
  final String image;
  final String title;
  final double price;

  BookItem({required this.id,
    required this.image,
    required this.title,
    required this.price});

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(onTap: () {
        Navigator.of(context).pushNamed(BookDetailScreen.routeName , arguments: id);
      },
        child: Card(
          color: Colors.grey,
          margin: EdgeInsets.all(2),

          elevation: 100,
          borderOnForeground: true,
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border_outlined)),
              ],
            ),
            Expanded(
              flex: 10,
              child: GridTile(
                child: Image.asset(image, fit: BoxFit.scaleDown),
              ),
            ),
            Text(
              title,textAlign: TextAlign.start, style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold),),
             Text(price.toString()),
            Row(children: [
              TextButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                            32,
                          )))),
                      backgroundColor: MaterialStatePropertyAll(Colors.brown)),
                  child: const Text(
                    'ADD TO BAG',
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  )),
              const SizedBox(
                width: 30,
              ),

            ])
          ]),
        ),
      );
  }
}
