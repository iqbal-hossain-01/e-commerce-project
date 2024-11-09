import 'package:e_commerce_app/screens/categories/category_list_screen.dart';
import 'package:e_commerce_app/screens/orders/order_list_screen.dart';
import 'package:e_commerce_app/screens/products/add_edit_product_screen.dart';
import 'package:e_commerce_app/screens/products/product_list_screen.dart';
import 'package:flutter/material.dart';

class DashboardModel {
  final String title;
  final IconData iconData;
  final String routeName;

  const DashboardModel({
    required this.title,
    required this.iconData,
    required this.routeName,
  });
}

const dashboardItems = [
  DashboardModel(
    title: 'Add Product',
    iconData: Icons.card_giftcard,
    routeName: AddEditProductScreen.routeName,
  ),
  DashboardModel(
    title: 'View Product',
    iconData: Icons.list,
    routeName: ProductListScreen.routeName,
  ),
  DashboardModel(
    title: 'View Category',
    iconData: Icons.category,
    routeName: CategoryListScreen.routeName,
  ),
  DashboardModel(
    title: 'View Order',
    iconData: Icons.monetization_on,
    routeName: OrderListScreen.routeName,
  ),
];
