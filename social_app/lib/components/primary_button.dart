import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: buildContainer(context),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: buildBoxDecoration(context),
      child: textContainer,
    );
  }

  BoxDecoration buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.colorScheme.secondary,
      borderRadius: BorderRadius.circular(12)
    );
  }

  Center get textContainer {
    return Center(
      child: buttonTitle
    );
  }

  Text get buttonTitle {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16
      ),
    );
  }
}
