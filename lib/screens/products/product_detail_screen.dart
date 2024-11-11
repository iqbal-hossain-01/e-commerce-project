import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/products/add_edit_product_screen.dart';
import 'package:e_commerce_app/utils/helper_functions.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = '/product-details/:id';

  const ProductDetailScreen({super.key});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  late String productId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productId = GoRouter.of(context).state!.pathParameters['id']!;
  }

  @override
  Widget build(BuildContext context) {
    final productAsyncValue = ref.watch(singleProductProvider(productId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          TextButton(
            onPressed: () {
              context.pushNamed(AddEditProductScreen.routeName);
            },
            child: const Text('Edit'),
          ),
        ],
      ),
      body: productAsyncValue.when(
        data: (product) {
          return ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        imageUrl: product.imageUrl!,
                        placeholder: (context, url) => const Center(
                          child: LoadingIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(
                            Icons.error_outline,
                            size: 50,
                          ),
                        ),
                        fadeInCurve: Curves.bounceInOut,
                        fadeInDuration: const Duration(milliseconds: 1000),
                      ),
                    ),
                    for (var imageUrl in product.additionalImages)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                          imageUrl: imageUrl,
                          placeholder: (context, url) => const Center(
                            child: LoadingIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.error_outline,
                              size: 50,
                            ),
                          ),
                          fadeInCurve: Curves.bounceInOut,
                          fadeInDuration: const Duration(milliseconds: 1000),
                        ),
                      ),
                  ],
                ),
              ),
              ListTile(
                tileColor: Colors.grey.withOpacity(0.1),
                title: SelectableText('Description: ${product.description}'),
              ),
              ListTile(
                title: SelectableText(product.productName),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      positiveButtonText: 'Update',
                      title: 'Update Product Name',
                      onSave: (value) {
                        ref.read(productProvider.notifier)
                            .updateSingleProductField(
                              product.id!,
                              'name',
                              value,
                            )
                            .then((_) {
                          ref.invalidate(singleProductProvider(productId));
                        });
                        showMsg(context, 'Product name updated');
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                tileColor: Colors.grey.withOpacity(0.1),
                title: Text('Category: ${product.categoryModel.name}'),
              ),
              ListTile(
                title: Text('Brand: ${product.brand}'),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      positiveButtonText: 'Update',
                      title: 'Update Brand Name',
                      onSave: (value) {
                        ref.read(productProvider.notifier)
                            .updateSingleProductField(
                              product.id!,
                              'brand',
                              value,
                            )
                            .then((_) {
                          ref.invalidate(singleProductProvider(productId));
                        });
                        showMsg(context, 'Brand name updated');
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                tileColor: Colors.grey.withOpacity(0.1),
                title: Text('Price: ${product.price}'),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      textInputType: TextInputType.number,
                      positiveButtonText: 'Update',
                      title: 'Update Price',
                      onSave: (value) {
                        ref.read(productProvider.notifier)
                            .updateSingleProductField(
                              product.id!,
                              'price',
                              double.parse(value),
                            )
                            .then((_) {
                          ref.invalidate(singleProductProvider(productId));
                        });
                        showMsg(context, 'Price updated');
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                title: Text('Discount: ${product.discount}%'),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      textInputType: TextInputType.number,
                      positiveButtonText: 'Update',
                      title: 'Update Discount',
                      onSave: (value) {
                        ref.read(productProvider.notifier)
                            .updateSingleProductField(
                              product.id!,
                              'discount',
                              int.parse(value),
                            )
                            .then((_) {
                          ref.invalidate(singleProductProvider(productId));
                        });
                        showMsg(context, 'Discount updated');
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                tileColor: Colors.grey.withOpacity(0.1),
                title:
                    Text('Price after discount: ${product.priceAfterDiscount}'),
              ),
              ListTile(
                title: Text('Stock: ${product.stock}'),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      textInputType: TextInputType.number,
                      positiveButtonText: 'Update',
                      title: 'Update Stock',
                      onSave: (value) {
                        ref.read(productProvider.notifier)
                            .updateSingleProductField(
                              product.id!,
                              'stock',
                              int.parse(value),
                            )
                            .then((_) {
                          ref.invalidate(singleProductProvider(productId));
                        });
                        showMsg(context, 'Stock updated');
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              SwitchListTile(
                tileColor: Colors.grey.withOpacity(0.1),
                value: product.stock != 0,
                title:
                    Text('Product available (stock != 0) : ${product.stock}'),
                onChanged: (value) {},
              ),
              ListTile(
                title: SelectableText('Sku: ${product.sku}'),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      positiveButtonText: 'Update',
                      title: 'Update sku',
                      onSave: (value) {
                        ref.read(productProvider.notifier)
                            .updateSingleProductField(
                              product.id!,
                              'sku',
                              value,
                            )
                            .then((_) {
                            ref.invalidate(singleProductProvider(productId));
                          },
                        );
                        showMsg(context, 'Sku updated');
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                tileColor: Colors.grey.withOpacity(0.1),
                title: Wrap(
                  children: [
                    const Text('Product Sizes: '),
                    for (var size in product.sizes) Text('$size '),
                  ],
                ),
              ),
              ListTile(
                title: Wrap(
                  children: [
                    const Text('Product Colors: '),
                    for (var color in product.colors) Text('$color '),
                  ],
                ),
              ),
              ListTile(
                tileColor: Colors.grey.withOpacity(0.1),
                title: Wrap(
                  children: [
                    const Text('Product Tags: '),
                    for (var tag in product.tags) Text('$tag  '),
                  ],
                ),
              ),
              ListTile(title: Text('Last update date: ${product.createdAt}')),
            ],
          );
        },
        error: (error, stackTrace) => Center(
          child: Text('Error loading product: $error'),
        ),
        loading: () => const Center(
          child: LoadingIndicator(),
        ),
      ),
    );
  }
}
