import 'product_item.dart';

class OrderItem {
  final String id;
  final String name;
  final double price;
  final List<ProductItem> products;
  final DateTime createAt;
  final DateTime updateAt;

  OrderItem(
      {required this.id,
      required this.name,
      required this.price,
      required this.products,
      required this.createAt,
      required this.updateAt});
}
