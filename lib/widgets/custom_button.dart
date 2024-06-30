import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.txt,
      required this.color});
  final String txt;
  final VoidCallback onPressed;
  final Color color;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(color: widget.color),
        child: Text(widget.txt),
      ),
    );
  }
}
