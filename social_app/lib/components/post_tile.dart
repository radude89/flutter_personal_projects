import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';

import '../models/post.dart';

class PostTile extends StatefulWidget {
  final Post post;
  const PostTile({super.key, required this.post});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: buildContent(context),
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

  Row buildTopSection(BuildContext context) {
    return Row(
      children: [
        buildIcon(context),
        const SizedBox(width: 10),
        buildPostName(context),
        const SizedBox(width: 5),
        buildPostUsername(context)
      ],
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
