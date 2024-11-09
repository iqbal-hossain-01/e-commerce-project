
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
 // final String hintText;
  final String labelText;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.validator,

  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(),
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        ),
        validator: validator,
      ),
    );
  }
}
