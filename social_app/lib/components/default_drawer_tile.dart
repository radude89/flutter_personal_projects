import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class DefaultDrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const DefaultDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: createTitle(context),
      leading: createIcon(context),
      onTap: onTap,
    );
  }

  Icon createIcon(BuildContext context) {
    return Icon(
      icon,
      color: context.colorScheme.primary,
    );
  }

  Text createTitle(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: context.colorScheme.inversePrimary
      ),
    );
  }
}
