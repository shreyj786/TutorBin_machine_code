import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomOutlineButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Colors.orange,
            width: .4,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          text,
          style: const TextStyle(color: Colors.orange, fontSize: 15),
        ),
      ),
    );
  }
}
