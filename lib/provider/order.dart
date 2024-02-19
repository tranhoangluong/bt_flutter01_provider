import 'package:flutter/material.dart';

import '../model/order_item.dart';
import '../model/product_item.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  void addOrder(List<ProductItem> productItems) {
    _items.add(OrderItem(
        id: DateTime.now().toString(),
        name: 'Product',
        price: productItems.fold(
            0,
            (previousValue, element) =>
                previousValue + element.price * element.quantity),
        products: [...productItems],
        createAt: DateTime.now(),
        updateAt: DateTime.now()));
    notifyListeners();
  }
}
