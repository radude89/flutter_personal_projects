import 'package:flutter/material.dart';
import 'package:social_app/components/post_tile.dart';
import 'package:social_app/helpers/navigate_pages.dart';
import 'package:social_app/utils/context_theme_ext.dart';

import '../models/post.dart';

class PostPage extends StatefulWidget {
  final Post post;

  const PostPage({
    super.key,
    required this.post,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        foregroundColor: context.colorScheme.primary,
      ),
      body: buildListView(context),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
      children: [
        PostTile(
          post: widget.post,
          onUserTap: () => goToUserPage(context, widget.post.uid),
          onPostTap: () {},
        )
      ],
    );
  }
}
