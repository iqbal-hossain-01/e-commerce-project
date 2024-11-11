import 'dart:io';

import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/category_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/utils/helper_functions.dart';
import 'package:e_commerce_app/widgets/custom_text_field.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddEditProductScreen extends ConsumerStatefulWidget {
  static const String routeName = '/addEditProduct';

  const AddEditProductScreen({super.key});

  @override
  ConsumerState<AddEditProductScreen> createState() =>
      _AddEditProductScreenState();
}

class _AddEditProductScreenState extends ConsumerState<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _discountController = TextEditingController();
  final _skuController = TextEditingController();
  final _brandController = TextEditingController();
  CategoryModel? selectedCategory;
  String? localImagePath;
  List<String> tags = [];
  List<String> additionalImages = [];
  List<String> colors = [];
  List<String> sizes = [];
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();

  //final TextEditingController _additionalImageController = TextEditingController();
  List<XFile> additionalImageFiles = [];

  @override
  Widget build(BuildContext context) {
    final categoriesList = ref.watch(categoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [
          IconButton(
            onPressed: _saveProduct,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Card(
                        elevation: 3,
                        child: localImagePath == null
                            ? const Icon(
                                Icons.person,
                                size: 120,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(localImagePath!),
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Positioned(
                        right: -10,
                        bottom: 100,
                        child: localImagePath != null
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    localImagePath = null;
                                  });
                                },
                                icon: const Icon(Icons.remove_circle, color: Colors.red,),)
                            : const Icon(null),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _getImage(ImageSource.camera);
                        },
                        label: const Column(
                          children: [
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Camera'),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          _getImage(ImageSource.gallery);
                        },
                        label: const Column(
                          children: [
                            Icon(Icons.photo_camera_back),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Gallery'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomTextField(
              controller: _nameController,
              labelText: 'Product Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Product name is empty';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _descriptionController,
              labelText: 'Product Description',
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description is empty';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _priceController,
              labelText: 'Product Price',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Product price is empty';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _stockController,
              labelText: 'Product Stock',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Product Stock is empty';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _discountController,
              labelText: 'Discount %',
              keyboardType: TextInputType.number,
              validator: (value) {
                return null;
              },
            ),
            CustomTextField(
              controller: _skuController,
              labelText: 'Product SKU',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'SKU is empty';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _brandController,
              labelText: 'Product Brand',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Brand is empty';
                }
                return null;
              },
            ),
            categoriesList.when(
              data: (categories) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
                  child: DropdownButtonFormField<CategoryModel>(
                    value: selectedCategory,
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (CategoryModel? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Select Category',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                );
              },
              error: (err, stack) => Center(child: Text('Error: $err')),
              loading: () => const Center(
                child: LoadingIndicator(),
              ),
            ),
            CustomTextField(
              controller: _tagController,
              labelText: 'Tags',
              validator: (value) => null,
            ),
            if (tags.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tags.map((tag) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Chip(
                        //padding: const EdgeInsets.all(8),
                        label: Text(tag),
                        deleteIcon: const Icon(Icons.remove_circle_outline),
                        onDeleted: () {
                          setState(() {
                            tags.remove(tag);
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_tagController.text.isNotEmpty) {
                      tags.add(_tagController.text);
                      _tagController.clear();
                    }
                  });
                },
                child: const Text('Add Tag'),
              ),
            ),
            CustomTextField(
              controller: _colorController,
              labelText: 'Colors',
              validator: (value) => null,
            ),
            if (colors.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: colors.map((color) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Chip(
                        label: Text(color),
                        deleteIcon: const Icon(Icons.remove_circle_outline),
                        onDeleted: () {
                          setState(() {
                            tags.remove(color);
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_colorController.text.isNotEmpty) {
                      colors.add(_colorController.text);
                      _colorController.clear();
                    }
                  });
                },
                child: const Text('Add Color'),
              ),
            ),
            CustomTextField(
              controller: _sizeController,
              labelText: 'Sizes',
              keyboardType: TextInputType.number,
              validator: (value) => null,
            ),
            if (sizes.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: sizes.map((size) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Chip(
                        label: Text(size),
                        deleteIcon: const Icon(Icons.remove_circle_outline),
                        onDeleted: () {
                          setState(() {
                            tags.remove(size);
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_sizeController.text.isNotEmpty) {
                      sizes.add(_sizeController.text);
                      _sizeController.clear();
                    }
                  });
                },
                child: const Text('Add Size'),
              ),
            ),
            if (additionalImageFiles.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: additionalImageFiles.asMap().entries.map((entry) {
                    int index = entry.key;
                    XFile file = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Stack(children: [
                        Image.file(
                          File(file.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                additionalImageFiles.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ]),
                    );
                  }).toList(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
              child: ElevatedButton(
                onPressed: _pickAdditionalImage,
                child: const Text('Pick Additional Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 60,
    );
    if (xFile != null) {
      setState(() {
        localImagePath = xFile.path;
      });
    }
  }

  Future<void> _pickAdditionalImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );
    if (pickedFile != null) {
      setState(() {
        additionalImageFiles.add(pickedFile);
      });
    }
  }

  void _saveProduct() async {
    if (localImagePath == null) {
      showMsg(context, 'Main Image not selected');
      return;
    }
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Saving...');
      configLoading();
      try {
        final mainImageUrl = await ref
            .read(productProvider.notifier)
            .uploadImageToStorage(localImagePath!);

        List<String> additionalImageUrls = [];
        for (var file in additionalImageFiles) {
          try {
            final imageUrl = await ref
                .read(productProvider.notifier)
                .uploadImageToStorage(file.path);
            additionalImageUrls.add(imageUrl);
          } catch (e) {
            showMsg(context, 'Failed to upload additional image: $e');
          }
        }

        final product = ProductModel(
          productName: _nameController.text,
          categoryModel: selectedCategory!,
          description: _descriptionController.text,
          price: double.parse(_priceController.text),
          stock: int.parse(_stockController.text),
          discount: _discountController.text.isEmpty
              ? 0
              : int.parse(_discountController.text),
          sku: _skuController.text,
          brand: _brandController.text,
          imageUrl: mainImageUrl,
          tags: tags,
          colors: colors,
          sizes: sizes,
          additionalImages: additionalImageUrls,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await ref.read(productProvider.notifier).addNewProduct(product);
        _resetFields();
        EasyLoading.dismiss();
        showMsg(context, 'Product added successfully');
      } catch (e) {
        EasyLoading.dismiss();
        showMsg(context, 'Failed to add product: ${e.toString()}');
      }
    }
  }

  void _resetFields() {
    setState(() {
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _stockController.clear();
      _discountController.clear();
      _skuController.clear();
      _brandController.clear();
      selectedCategory = null;
      localImagePath = null;
      tags.clear();
      additionalImageFiles.clear();
      colors.clear();
      sizes.clear();
    });
  }
}
