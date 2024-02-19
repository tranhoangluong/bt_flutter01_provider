import 'package:bt_flutter01_provider/model/product_item.dart';
import 'package:flutter/foundation.dart';

final List<ProductItem> orderProductsList = [];

class CartOrderContainer with ChangeNotifier {
  final List<ProductItem> _items = [];
  final List<ProductItem> _selectedItems = [];

  bool isDeleteMode = false;

  List<ProductItem> get cartItems => _items;

  List<ProductItem> get selectedItems => _selectedItems;

  double get totalPrice {
    double total = 0;

    for (var element in _items) {
      total += element.price * element.quantity;
    }
    return total;
  }

  void addToCart(ProductItem orderProduct) {
    final productIndex = _items.indexWhere((e) => e.id == orderProduct.id);
    if (kDebugMode) {
      print(orderProduct.name);
    }
    if (productIndex < 0) {
      _items.add(orderProduct);
    } else {
      _items[productIndex] =
          orderProduct.copyWith(quantity: _items[productIndex].quantity + 1);
    }
    notifyListeners();
  }

  void degreeProd(ProductItem orderProduct) {
    final productIndex = _items.indexWhere((e) => e.id == orderProduct.id);
    if (_items[productIndex].quantity > 1) {
      _items[productIndex] =
          orderProduct.copyWith(quantity: _items[productIndex].quantity - 1);
    } else {
      _items.removeAt(productIndex);
    }
    notifyListeners();
  }

  void toggleSelected(ProductItem orderProduct) {
    final productIndex =
        _selectedItems.indexWhere((e) => e.id == orderProduct.id);
    if (productIndex < 0) {
      _selectedItems.add(orderProduct);
    } else {
      _selectedItems.removeWhere((e) => e.id == orderProduct.id);
    }
    notifyListeners();
  }

  void deleteSelected() {
    for (var element in _selectedItems) {
      _items.removeWhere((e) => e.id == element.id);
    }
    _selectedItems.clear();
    notifyListeners();
  }

  void undoDelete(List<ProductItem> oldSelectedItems) {
    _items.addAll(oldSelectedItems);
    _selectedItems.addAll(oldSelectedItems);
    notifyListeners();
  }

  void toggleDeleteMode() {
    isDeleteMode = !isDeleteMode;
    notifyListeners();
  }

  bool isSelected(ProductItem orderProduct) {
    return _selectedItems.indexWhere((e) => e.id == orderProduct.id) >= 0;
  }

  void clearCart() {
    isDeleteMode = false;
    _items.clear();
    _selectedItems.clear();
    notifyListeners();
  }
}
