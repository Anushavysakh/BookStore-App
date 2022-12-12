import 'package:book_store_app/screens/cart_screen.dart';
import 'package:book_store_app/screens/search_screen.dart';
import 'package:book_store_app/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/books.dart';
import '../providers/cart.dart';
import '../widgets/app_drawer.dart';
import '../widgets/books_grid.dart';

enum FilterOptions {
  WishList,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyWishlist = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
      if (_isInit) {
        setState(() {
          _isLoading = true;
        });
        Provider.of<Books>(context).fetchAndSetProducts().then(
              (_) {
            if(mounted){
              setState(() {
                _isLoading = false;
              });}
          },
        );
      }
      _isInit = false;
      super.didChangeDependencies();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade200,
      drawer: AppDrawer(),
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
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SearchScreen.routeName);
              },
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
          // PopupMenuButton(
          //     onSelected: (FilterOptions selectedValue) {
          //       setState(() {
          //         if(selectedValue == FilterOptions.WishList){
          //           _showOnlyWishlist = true;
          //         } else {
          //           _showOnlyWishlist = false;
          //         }
          //       });
          //
          //       print(selectedValue);
          //     },
          //     icon: Icon(Icons.more_vert),
          //     itemBuilder: (context) => [
          //           PopupMenuItem(
          //             child: Text('Wishlist'),
          //             value: FilterOptions.WishList,
          //           ),
          //           PopupMenuItem(
          //             child: Text('Show All'),
          //             value: FilterOptions.All,
          //           )
          //         ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch!,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      body: BooksGrid(_showOnlyWishlist),
    );
  }
}
