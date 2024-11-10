import 'dart:io';

import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = StateNotifierProvider<ProductNotifier, AsyncValue<String>>(
  (ref) => ProductNotifier(),
);

class ProductNotifier extends StateNotifier<AsyncValue<String>> {
  ProductNotifier() : super(const AsyncValue.loading());

  Future<void> addNewProduct(ProductModel model) async {
    try {
      state = const AsyncValue.loading();
      await FirestoreService.addProduct(model);
      state = const AsyncValue.data('Product added successfully');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
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
