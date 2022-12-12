import 'package:book_store_app/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        title: Text('Your Cart..'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                  backgroundColor: Colors.purple.shade300,
                ),
                Spacer(),

                // TextButton(
                //     onPressed: () {
                //       Provider.of<Orders>(context, listen: false).addOrder(
                //           cart.items.values.toList(), cart.totalAmount);
                //       cart.clear();
                //     },
                //     child: Text('ORDER NOW')),
                OrderButton(cart: cart),
              ]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) => CartsItem(
                id: cart.items.values.toList()[index].id,
                title: cart.items.values.toList()[index].title,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
                productId: cart.items.keys.toList()[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              final items = widget.cart.items.values.toList();

              await Provider.of<Orders>(context, listen: false)
                  .addOrder(items, widget.cart.totalAmount);
              setState(() {
                _isLoading = false;
              });

              widget.cart.clear();
            },
      child: _isLoading ? CircularProgressIndicator() : Text("Order Now"),
    );
  }
}
