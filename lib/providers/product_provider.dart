import 'dart:io';

import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final singleProductProvider = FutureProvider.family<ProductModel, String>(
    (ref, id) {
      final product =  ref.read(productProvider.notifier).getProductFromListById(id);
      return product;
    }
);

final productProvider = StateNotifierProvider<ProductNotifier, AsyncValue<List<ProductModel>>>(
  (ref) => ProductNotifier(),
);

class ProductNotifier extends StateNotifier<AsyncValue<List<ProductModel>>> {
  ProductNotifier() : super(const AsyncValue.loading());

  List<ProductModel> productList = [];

  Future<void> getProducts() async {
    try {
      FirestoreService.fetchProducts().listen((snapshot){
         productList = List.generate(snapshot.docs.length,
            (index) => ProductModel.fromMap(snapshot.docs[index].data()));
        state = AsyncValue.data(productList);
      });
    } catch (e, stackTrace){
      state = AsyncValue.error(e, stackTrace);
    }
  }

  ProductModel getProductFromListById(String id) {
    return productList.firstWhere((product) => product.id == id);
  }

  Future<void> updateSingleProductField(String id, String field, dynamic value) {
    return FirestoreService.updateSingleProductField(id, field, value,);
  }

  Future<void> addNewProduct(ProductModel model) async {
    await FirestoreService.addProduct(model);
    await getProducts();
  }

  Future<String> uploadImageToStorage(String localPath) async {
    try {
      final imageName = 'Image_${DateTime.now().millisecondsSinceEpoch}';
      final imageRef = FirebaseStorage.instance.ref().child('Image/$imageName');
      final task = imageRef.putFile(File(localPath));

      final snapshot = await task.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
