import 'package:book_store_app/providers/auth.dart';
import 'package:book_store_app/providers/book.dart';
import 'package:book_store_app/providers/books.dart';
import 'package:book_store_app/providers/cart.dart';
import 'package:book_store_app/providers/orders.dart';
import 'package:book_store_app/screens/auth_screen.dart';
import 'package:book_store_app/screens/book_detail_screen.dart';
import 'package:book_store_app/screens/cart_screen.dart';
import 'package:book_store_app/screens/order_screen.dart';
import 'package:book_store_app/screens/products_overview_screen.dart';
import 'package:book_store_app/screens/search_screen.dart';
import 'package:book_store_app/screens/splash_screen.dart';
import 'package:book_store_app/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Books>(
            create: (_) => Books('', [], ''),
            update: (context, auth, previousBooks) {
              return Books(
                  auth.token,
                  previousBooks == null ? [] : previousBooks.items,
                  auth.userId);
            }),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders([], '', ''),
          update: (ctx, auth, previousOrders) {
            return Orders(
              previousOrders == null ? [] : previousOrders.orders,
              auth.token,
              auth.userId,
            );
          },
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              pageTransitionsTheme: PageTransitionsTheme(builders: {})),
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            BookDetailScreen.routeName: (context) => BookDetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            WishList.routeName: (context) => WishList(),
            SearchScreen.routeName: (context) => SearchScreen()
          },
        ),
      ),
    );
  }
}
