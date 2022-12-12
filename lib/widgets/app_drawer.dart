import 'package:book_store_app/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple.shade200,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'BookStore',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
              title: const Text(('Shop')),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          ListTile(
            title: Text(('Wish List')),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(WishList.routeName);
            },
          ),
          ListTile(
            title: Text(
              ('Orders'),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),

          ListTile(
            title: Text(('LogOut')),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context,listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
