
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEditProductScreen extends ConsumerWidget {
  static const String routeName = '/addEditProduct';

  const AddEditProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
    );
  }
}
