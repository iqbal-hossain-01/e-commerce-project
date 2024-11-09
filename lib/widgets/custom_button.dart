import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColorDark,
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
