import 'package:e_commerce_app/screens/auth/launcher_screen.dart';
import 'package:e_commerce_app/screens/auth/login_screen.dart';
import 'package:e_commerce_app/screens/categories/category_list_screen.dart';
import 'package:e_commerce_app/screens/dashboard/dashboard_screen.dart';
import 'package:e_commerce_app/screens/orders/order_list_screen.dart';
import 'package:e_commerce_app/screens/products/add_edit_product_screen.dart';
import 'package:e_commerce_app/screens/products/product_list_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter{
  AppRouter._();
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: LauncherScreen.routeName,
        builder: (context, state) => const LauncherScreen(),
      ),
      GoRoute(
        path: LoginScreen.routeName,
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: DashboardScreen.routeName,
        name: DashboardScreen.routeName,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        name: CategoryListScreen.routeName,
        path: CategoryListScreen.routeName,
        builder: (context, state) => const CategoryListScreen(),
      ),
      GoRoute(
        name: ProductListScreen.routeName,
        path: ProductListScreen.routeName,
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        name: AddEditProductScreen.routeName,
        path: AddEditProductScreen.routeName,
        builder: (context, state) => const AddEditProductScreen(),
      ),
      GoRoute(
        name: OrderListScreen.routeName,
        path: OrderListScreen.routeName,
        builder: (context, state) => const OrderListScreen(),
      ),
    ]
  );
}