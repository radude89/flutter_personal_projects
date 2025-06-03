import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';

import '../models/post.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  final void Function()? onPostTap;

  const PostTile({
    super.key,
    required this.post,
    required this.onUserTap,
    required this.onPostTap,
  });

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPostTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 5
        ),
        padding: const EdgeInsets.all(20),
        decoration: buildBoxDecoration(context),
        child: buildContent(context),
      ),
    );
  }

  BoxDecoration buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.colorScheme.secondary,
      borderRadius: BorderRadius.circular(8),
    );
  }

  Column buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTopSection(context),
        const SizedBox(height: 20),
        buildPostMessageContent(context)
      ],
    );
  }

  Text buildPostMessageContent(BuildContext context) {
    return Text(
        widget.post.message,
        style: TextStyle(
          color: context.colorScheme.inversePrimary
        ),
      );
  }

  Widget buildTopSection(BuildContext context) {
    return GestureDetector(
      onTap: widget.onUserTap,
      child: Row(
        children: [
          buildIcon(context),
          const SizedBox(width: 10),
          buildPostName(context),
          const SizedBox(width: 5),
          buildPostUsername(context)
        ],
      ),
    );
  }

  Text buildPostUsername(BuildContext context) {
    return Text(
        '@${widget.post.username}',
        style: TextStyle(
          color: context.colorScheme.primary
        ),
      );
  }

  Text buildPostName(BuildContext context) {
    return Text(
        widget.post.name,
        style: TextStyle(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.bold
        ),
      );
  }

  Icon buildIcon(BuildContext context) {
    return Icon(
        Icons.person,
        color: context.colorScheme.primary,
      );
  }
}
