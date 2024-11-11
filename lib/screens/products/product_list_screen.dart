import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/products/product_detail_screen.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductListScreen extends ConsumerWidget {
  static const String routeName = '/allProduct';

  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Product'),
      ),
      body: productList.when(
        data: (products) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                onTap: () => context.pushNamed(
                  ProductDetailScreen.routeName,
                  pathParameters: {'id': product.id.toString()},
                ),
                title: Text(product.productName),
                subtitle: Text(product.categoryModel.name),
                trailing: Text('Stock: ${product.stock}'),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error'),),
        loading: () => const Center(child: LoadingIndicator(),),
      ),
    );
  }
}
