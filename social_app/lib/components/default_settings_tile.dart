import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class DefaultSettingsTile extends StatelessWidget {
  final String title;
  final Widget action;

  const DefaultSettingsTile({
    super.key,
    required this.title,
    required this.action
  });

  @override
  Widget build(BuildContext context) {
    const margin = EdgeInsets.only(left: 25, right: 25, top: 10);
    const padding = EdgeInsets.all(15);
    return createContainer(margin, padding, context);
  }

  Widget createContainer(
      EdgeInsets margin,
      EdgeInsets padding,
      BuildContext context
  ) {
    return Container(
      decoration: createContainerDecoration(context),
      margin: margin,
      padding: padding,
      child: createMainContent(),
    );
  }

  BoxDecoration createContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.colorScheme.secondary,
      borderRadius: BorderRadius.circular(12)
    );
  }

  Widget createMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        createTitleText(),
        action
      ],
    );
  }

  Widget createTitleText() {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold
      ),
    );
  }
}
