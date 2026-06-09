import 'cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final String paymentMethod;
  final String address;
  final String city;
  final String pincode;
  final String phone;
  final DateTime date;
  final String status;

  const Order({
    required this.id,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.address,
    required this.city,
    required this.pincode,
    required this.phone,
    required this.date,
    this.status = 'Confirmed',
  });
}
