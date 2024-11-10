
import 'package:e_commerce_app/models/category_model.dart';


class ProductModel {
  String? id;
  final String productName;
  CategoryModel categoryModel;
  final String description;
  final double price;
  final int stock;
  final int discount;
  final String sku;
  final String brand;
  final String? imageUrl;
  final List<String> tags;
  final List<String> colors;
  final List<String> sizes;
  final List<String> additionalImages;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    this.id,
    required this.productName,
    required this.categoryModel,
    required this.description,
    required this.price,
    required this.stock,
    required this.discount,
    required this.sku,
    required this.brand,
    this.imageUrl,
    required this.tags,
    required this.colors,
    required this.sizes,
    required this.additionalImages,
    this.createdAt,
    this.updatedAt,
  });

  // Convert ProductModel to a Map (for saving to database or JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': productName,
      'categoryModel': categoryModel.toMap(),
      'description': description,
      'price': price,
      'stock': stock,
      'discount': discount,
      'sku': sku,
      'brand': brand,
      'imageUrl': imageUrl,
      'tags': tags,
      'colors': colors,
      'sizes': sizes,
      'additionalImages': additionalImages,
      'createdAt': createdAt?.toIso8601String(), // Convert DateTime to ISO 8601 string
      'updatedAt': updatedAt?.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }

  // Convert a Map to ProductModel (for retrieving from database or JSON)
  factory ProductModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return ProductModel(
      id: id ?? map['id'],
      productName: map['name'] ?? '',
      categoryModel: CategoryModel.fromMap(map['categoryModel']),
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      stock: map['stock'] ?? 0,
      discount: map['discount'] ?? 0,
      sku: map['sku'] ?? '',
      brand: map['brand'] ?? '',
      imageUrl: map['imageUrl'],
      tags: List<String>.from(map['tags'] ?? []),
      colors: List<String>.from(map['colors'] ?? []),
      sizes: List<String>.from(map['sizes'] ?? []),
      additionalImages: List<String>.from(map['additionalImages'] ?? []),
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}

