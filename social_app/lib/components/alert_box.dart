import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class AlertBox extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final void Function()? onPressed;
  final String onPressedText;

  const AlertBox({
    super.key,
    required this.textController,
    required this.hintText,
    required this.onPressed,
    required this.onPressedText
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8)
        ),
      ),
      backgroundColor: context.colorScheme.surface,
      content: buildTextField(context),
      actions: buildActions(context),
    );
  }

  List<Widget> buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          textController.clear();
        },
        child: const Text("Cancel")
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          onPressed!();
          textController.clear();
        },
        child: Text(onPressedText)
      )
    ];
  }

  TextField buildTextField(BuildContext context) {
    return TextField(
      controller: textController,
      maxLength: 140,
      maxLines: 3,
      decoration: buildInputDecoration(context),
    );
  }

  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
      enabledBorder: buildOutlineInputBorder(
        context,
        context.colorScheme.tertiary
      ),
      focusedBorder: buildOutlineInputBorder(
          context,
          context.colorScheme.primary
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: context.colorScheme.primary
      ),
      fillColor: context.colorScheme.secondary,
      filled: true,
      counterStyle: TextStyle(
        color: context.colorScheme.primary
      )
    );
  }

  OutlineInputBorder buildOutlineInputBorder(
      BuildContext context,
      Color color
  ) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
