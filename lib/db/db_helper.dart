import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/models/app_user_model.dart';
import 'package:ecom_user/models/cart_model.dart';

class DbHelper {
  final _db = FirebaseFirestore.instance;
  final String collectionAdmin = 'Admin';
  final String collectionCategory = 'Categories';
  final String collectionProduct = 'Products';
  final String collectionUser = 'Users';
  final String collectionCart = 'Cart';

  Future<void> addNewUser(AppUserModel appUserModel) {
    return _db.collection(collectionUser).doc(appUserModel.uid).set(appUserModel.toJson());
  }

  Future<void> addToCart(CartModel cartModel, String uid) {
    return _db.collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(cartModel.productId)
        .set(cartModel.toJson());
  }

  Future<void> removeFromCart(String pid, String uid) {
    return _db.collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(pid).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).orderBy('name').snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCartItem(String uid) =>
      _db.collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .snapshots();

  Future<void> updateCartQuantity(String uid, String pid, num quantity) {
    return _db.collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(pid)
        .update({'quantity': quantity});
  }
}