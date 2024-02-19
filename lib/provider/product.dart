import 'package:bt_flutter01_provider/model/product_item.dart';
import 'package:flutter/material.dart';

final List<ProductItem> productItems = <ProductItem>[
  ProductItem(
      id: '1',
      name: 'Product 1',
      price: 100,
      quantity: 1,
      image:
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      description: 'Ok'),
  ProductItem(
      id: '2',
      name: 'Product 2',
      price: 100,
      quantity: 1,
      image:
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      description: 'Ok'),
];

class ProductContainer with ChangeNotifier {
  final List<ProductItem> _items = productItems; // init default product items

  List<ProductItem> get items => _items;

  void addProduct(ProductItem productItem) {
    _items.add(productItem);
    notifyListeners();
  }

  void removeProduct(ProductItem productItem) {
    _items.removeWhere((element) => productItem.id == element.id);
    notifyListeners();
  }

  void updateProduct(ProductItem productItem) {
    final index = _items.indexWhere((element) => productItem.id == element.id);
    _items[index] = productItem;
    notifyListeners();
  }
}
