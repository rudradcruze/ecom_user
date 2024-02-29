import 'package:ecom_user/auth/auth_service.dart';
import 'package:ecom_user/db/db_helper.dart';
import 'package:ecom_user/models/cart_model.dart';
import 'package:ecom_user/models/product_model.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];
  final _db = DbHelper();

  bool isInCart(String pid) {
    bool flag = false;
    for (final cart in cartList) {
      if (cart.productId == pid) {
        flag = true;
        break;
      }
    }
    return flag;
  }

  Future<void> addToCart(ProductModel productModel) {
    final cartModel = CartModel(
      productId: productModel.productId!,
      productName: productModel.productName,
      imageUrl: productModel.imageUrl,
      price: productModel.priceAfterDiscount,
    );
    return _db.addToCart(cartModel, AuthService.uid);
  }

  Future<void> removeFromCart(String pid) {
    return _db.removeFromCart(pid, AuthService.uid);
  }

  void getAllCartItem() {
    _db.getAllCartItem(AuthService.uid).listen((snapshot) {
      cartList = List.generate(snapshot.docs.length,
          (index) => CartModel.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}

extension on ProductModel {
  num get priceAfterDiscount => price - ((price * discount) / 100);
}
