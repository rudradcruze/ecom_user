import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/models/app_user_model.dart';
import 'package:ecom_user/models/cart_model.dart';
import 'package:ecom_user/models/order_model.dart';

class DbHelper {
  final _db = FirebaseFirestore.instance;
  final String collectionAdmin = 'Admin';
  final String collectionCategory = 'Categories';
  final String collectionProduct = 'Products';
  final String collectionUser = 'Users';
  final String collectionCart = 'Cart';
  final String collectionOrder = 'Order';
  final String collectionSettings = 'Settings';
  final String documentOrderConstants = 'OrderConstants';

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

  Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants() =>
      _db.collection(collectionSettings).doc(documentOrderConstants).snapshots();

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

  Future<void> clearCart(String uid) async {
    final wb = _db.batch();
    var snapshot = await _db.collection(collectionUser).doc(uid)
        .collection(collectionCart).get();
    for (final doc in snapshot.docs) {
      final docId = doc.data()['productId'];
      final cartDoc = _db.collection(collectionUser).doc().collection(collectionCart).doc(docId);
      wb.delete(cartDoc);
    }
    return wb.commit();
  }

  Future<void> saveOrder(OrderModel orderModel) async {
    final wb = _db.batch();
    final orderDoc = _db.collection(collectionOrder).doc(orderModel.orderId);
    wb.set(orderDoc, orderModel.toJson());

    for (final map in orderModel.orderDetails) {
      final productSnapshot = await _db.collection(collectionProduct).doc(map['productId']).get();
      final prevStock = productSnapshot.data()!['stock'];
      final newStock = prevStock - map['quantity'];
      final proDoc = _db.collection(collectionProduct).doc(map['productId']);
      wb.update(proDoc, {'stock' : newStock});
    }

    return wb.commit();
  }
}