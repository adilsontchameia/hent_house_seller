import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });
  final String? label;
  final VoidCallback onPressed;

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
      child: Text(widget.label!),
    );
  }
}
