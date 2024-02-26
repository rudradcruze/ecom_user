import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  final _db = FirebaseFirestore.instance;
  final String collectionAdmin = 'Admin';
  final String collectionCategory = 'Categories';
  final String collectionProduct = 'Products';

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).orderBy('name').snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();
}