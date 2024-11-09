import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/screens/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
    );
  }
}
