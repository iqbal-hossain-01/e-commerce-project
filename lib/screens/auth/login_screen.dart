import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/screens/dashboard/dashboard_screen.dart';
import 'package:e_commerce_app/utils/constants.dart';
import 'package:e_commerce_app/utils/helper_functions.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                    controller: _emailController,
                    labelText: ' Email',
                    prefixIcon: const Icon(Icons.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    }),
                const SizedBox(height: 16),
                CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.password),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    }),
                const SizedBox(height: 24),
                CustomButton(text: 'Log in as Admin', onPressed: _loginAdmin),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  _error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginAdmin() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      EasyLoading.show(
        status: 'Please wait...',
        maskType: EasyLoadingMaskType.black
      );
      configLoading();
      /*
      try {
        await ref.read(firebaseAuthProvider.notifier).login(email, password);
        context.pushReplacementNamed(DashboardScreen.routeName);
      } on FirebaseAuthException catch (err) {
        setState(() {
          _error = 'Login Failed: ${err.code}';
        });
      } finally {
        EasyLoading.dismiss();
      }

       */
      /*
      try {
        final isAdmin = await ref.read(firebaseAuthProvider.notifier)
            .login(email, password);
        if (isAdmin) {
          context.pushReplacementNamed(DashboardScreen.routeName);
        } else {
          await ref.read(firebaseAuthProvider.notifier).logout();
          setState(() {
            //_error = wrongAdminLoginMsg;
          });
        }
      } on FirebaseException catch (err) {
        setState(() {
          _error = 'Login Failed: ${err.message}';
        });
      } finally {
        EasyLoading.dismiss();
      }

       */
      try {
        final authProvider = ref.read(firebaseAuthProvider.notifier);
        final isLoginSuccessful = await authProvider.login(email, password);

        if (isLoginSuccessful) {
          final isAdmin = await authProvider.checkAdmin();

          if (isAdmin) {
            context.pushReplacementNamed(DashboardScreen.routeName);
          } else {
            await authProvider.logout();
            setState(() {
              _error = wrongAdminLoginMsg;
            });
          }
        } else {
          setState(() {
            _error = 'Invalid email or password';
          });
        }
      } catch (err) {
        //
      } finally {
        EasyLoading.dismiss();
      }

    }
  }
}
