import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const CustomIconButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 14,
      iconSize: 20,
      color: Colors.orange,
      onPressed: onPressed,
      padding: const EdgeInsets.all(0),
      icon: icon,
    );
  }
}
