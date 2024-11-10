import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/product_model.dart';

class FirestoreService{
  FirestoreService._();
  static final _firestore = FirebaseFirestore.instance;
  static const String _collectionCategory = 'Categories';
  static const String _collectionProduct = 'Products';

  static Future<void> addProduct(ProductModel model) {
    final doc = _firestore.collection(_collectionProduct).doc();
    model.id = doc.id;
    return doc.set(model.toMap());
  }

  static Future<void> addCategory(CategoryModel model) {
    return _firestore.collection(_collectionCategory).add(model.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategories() =>
      _firestore.collection(_collectionCategory).orderBy('name').snapshots();
}