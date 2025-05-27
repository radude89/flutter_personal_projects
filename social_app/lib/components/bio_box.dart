import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class BioBox extends StatelessWidget {
  final String text;

  const BioBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.all(25),
      child: Text(
        text.isNotEmpty ? text : 'Empty bio...',
        style: TextStyle(color: context.colorScheme.inversePrimary),
      ),
    );
  }
}
