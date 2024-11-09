import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/screens/auth/login_screen.dart';
import 'package:e_commerce_app/screens/dashboard/dashboard_screen.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LauncherScreen extends ConsumerStatefulWidget {
  static const String routeName = '/';
  const LauncherScreen({super.key});

  @override
  ConsumerState<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends ConsumerState<LauncherScreen> {
  @override
  void didChangeDependencies() {
    final authProvider = ref.read(firebaseAuthProvider.notifier);
    Future.delayed(const Duration(seconds: 0), () {
      if (authProvider.currentUser != null) {
        context.pushReplacementNamed(DashboardScreen.routeName);
      } else {
        context.pushReplacementNamed(LoginScreen.routeName);
      }
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return const LoadingIndicator();
  }
}

