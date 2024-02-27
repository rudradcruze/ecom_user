import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/models/app_user_model.dart';

class DbHelper {
  final _db = FirebaseFirestore.instance;
  final String collectionAdmin = 'Admin';
  final String collectionCategory = 'Categories';
  final String collectionProduct = 'Products';
  final String collectionUser = 'Users';

  Future<void> addNewUser(AppUserModel appUserModel) {
    return _db.collection(collectionUser).doc(appUserModel.uid).set(appUserModel.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).orderBy('name').snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();
}