String generateOrderId() {
  final date = DateTime.now();
  return 'Order_${date.year}${date.month}${date.day}${date.millisecondsSinceEpoch}';
}
