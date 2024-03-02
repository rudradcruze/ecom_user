import 'package:ecom_user/db/db_helper.dart';
import 'package:ecom_user/models/order_constant_model.dart';
import 'package:ecom_user/models/order_model.dart';
import 'package:flutter/foundation.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantModel orderConstantModel = OrderConstantModel();
  final _db = DbHelper();

  Future<void> saveOrder(OrderModel orderModel) {
    return _db.saveOrder(orderModel);
  }

  getOrderConstant() {
    _db.getOrderConstants().listen((snapshot) {
      orderConstantModel = OrderConstantModel.fromJson(snapshot.data()!);
      notifyListeners();
    });
  }

  num getDiscountAmount(num subtotal) {
    return ((subtotal * orderConstantModel.discount) / 100).round();
  }

  num getVatAmount(num subtotal) {
    final totalAfterDiscount = subtotal - getDiscountAmount(subtotal);
    return ((totalAfterDiscount * orderConstantModel.vat) / 100).round();
  }

  num getGrantTotal(num subtotal) {
    return (subtotal - getDiscountAmount(subtotal)) + getVatAmount(subtotal);
  }
}