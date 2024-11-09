import 'package:e_commerce_app/screens/auth/launcher_screen.dart';
import 'package:e_commerce_app/screens/auth/login_screen.dart';
import 'package:e_commerce_app/screens/dashboard/dashboard_screen.dart';
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
        path: '/login',
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: DashboardScreen.routeName,
        builder: (context, state) => const DashboardScreen(),
      ),
    ]
  );
}