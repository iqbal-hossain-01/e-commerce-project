import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, AsyncValue<List<CategoryModel>>>(
  (ref) => CategoryNotifier(),
);

class CategoryNotifier extends StateNotifier<AsyncValue<List<CategoryModel>>> {
  CategoryNotifier() : super(const AsyncValue.loading()) {
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      FirestoreService.fetchCategories().listen((snapshot) {
        final categoriesList = List.generate(snapshot.docs.length,
                (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
        state = AsyncValue.data(categoriesList);
      });
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addNewCategory(String name) async {
    final model = CategoryModel(name);
    await FirestoreService.addCategory(model);
    await getCategories();
  }
}
