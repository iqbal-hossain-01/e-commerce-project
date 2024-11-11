import 'package:e_commerce_app/models/dashboard_model.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/category_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/auth/login_screen.dart';
import 'package:e_commerce_app/widgets/dashboard_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(categoryProvider.notifier).getCategories();
    ref.read(productProvider.notifier).getProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge,),
        actions: [
          TextButton.icon(
            onPressed: () {
              ref.read(firebaseAuthProvider.notifier).logout().then((_){
                context.pushReplacementNamed(LoginScreen.routeName);
              });

            },
            label: const Row(
              children: [
                Icon(Icons.logout_outlined),
                Text('LogOut'),
              ],
            ),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: dashboardItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final item = dashboardItems[index];
          return DashboardItemView(dashboardModel: item);
        },
      ),
    );
  }
}
