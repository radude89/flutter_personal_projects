import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const DefaultTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: createInputDecoration(context)
    );
  }

  InputDecoration createInputDecoration(BuildContext context) {
    var borderRadius = BorderRadius.circular(12);
    var primaryColor = context.colorScheme.primary;
    var secondaryColor = context.colorScheme.secondary;
    var tertiaryColor = context.colorScheme.tertiary;

    return InputDecoration(
      enabledBorder: createBorder(borderRadius, tertiaryColor),
      focusedBorder: createBorder(borderRadius, primaryColor),
      fillColor: secondaryColor,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(color: primaryColor)
    );
  }

  OutlineInputBorder createBorder(
    BorderRadius radius,
    Color color
  ) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: radius
    );
  }
}
