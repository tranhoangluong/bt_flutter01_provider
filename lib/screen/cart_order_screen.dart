
import 'package:bt_flutter01_provider/provider/cart_order.dart';
import 'package:bt_flutter01_provider/provider/order.dart';
import 'package:bt_flutter01_provider/screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartOrderScreen extends StatelessWidget {
  static const routeName = 'cart-order-products';

  const CartOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartOrder = Provider.of<CartOrderContainer>(context);

    final cartItems = cartOrder.cartItems;
    final totalPrice = cartOrder.totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  // const Expanded(
                  //   flex: 1,
                  //   child: Text(
                  //     'Total',
                  //     style: TextStyle(fontSize: 20),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '\$$totalPrice',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        child: const Text(
                          'ORDER NOW',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                        onPressed: () {
                          Provider.of<OrderProvider>(context, listen: false)
                              .addOrder(cartItems);
                          cartOrder.clearCart();
                          Navigator.of(context)
                              .popAndPushNamed(OrderScreen.routeName);
                        },
                      ),
                      const SizedBox(width: 5),
                      OutlinedButton(
                        onPressed: () {
                          if (cartOrder.isDeleteMode) {
                            if (cartOrder.selectedItems.isEmpty) {
                              cartOrder.toggleDeleteMode();
                              return;
                            }
                            final selectedItems = [...cartOrder.selectedItems];
                            cartOrder.deleteSelected();
                            cartOrder.toggleDeleteMode();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Deleted selected items'),
                              action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    cartOrder.undoDelete(selectedItems);
                                    cartOrder.toggleDeleteMode();
                                  }),
                            ));
                          } else {
                            cartOrder.toggleDeleteMode();
                          }
                        },
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                          width: 2,
                          color: Colors.red,
                        )),
                        child: Text(
                          cartOrder.isDeleteMode ? 'Delete Selected' : 'Delete',
                          style:
                              const TextStyle(fontSize: 13, color: Colors.red),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      children: [
                        if (cartOrder.isDeleteMode)
                          Checkbox(
                              value: cartOrder.isSelected(cartItems[index]),
                              onChanged: (value) {
                                cartOrder.toggleSelected(cartItems[index]);
                              }),
                        Container(
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            '\$${cartItems[index].price.toString()}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItems[index].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Total: \$${cartItems[index].price * cartItems[index].quantity}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                   Provider.of<CartOrderContainer>(context, listen: false).degreeProd(
                                      cartItems[index],
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  )),
                              const SizedBox(width: 5),
                              Text(
                                'x${cartItems[index].quantity}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                  onPressed: () {
                                    Provider.of<CartOrderContainer>(context, listen: false).addToCart(
                                      cartItems[index],
                                    );
                                  },
                                  icon: const Icon(Icons.add,
                                      color: Colors.blue)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
