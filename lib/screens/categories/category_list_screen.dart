import 'package:e_commerce_app/providers/category_provider.dart';
import 'package:e_commerce_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryListScreen extends ConsumerWidget {
  static const String routeName = '/allCategory';

  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ref.watch(categoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Categories'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSingleTextInputDialog(
            context: context,
            title: 'New Category',
            onSave: (value) async {
              EasyLoading.show(status: 'Please wait...');
              configLoading();
              await ref.read(categoryProvider.notifier).addNewCategory(value);
              EasyLoading.dismiss();
              showMsg(context, 'Category saved',);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: categoryList.when(
        data: (categories) {
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                title: Text(category.name),
              );
            },
          );
        },
        error: (error, stack) => Center(child: Text('Error: $error'),),
        loading: () => const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
