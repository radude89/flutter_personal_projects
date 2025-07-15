import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/alert_box.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/services/database/database_provider.dart';
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
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider = Provider
      .of<DatabaseProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  @override
  Widget build(BuildContext context) {
    bool likedByCurrentUser = listeningProvider
        .isPostLikedByCurrentUser(widget.post.id);
    int likeCount = listeningProvider
        .getLikeCount(widget.post.id);
    int commentsCount = listeningProvider
        .getComments(widget.post.id).length;

    return GestureDetector(
      onTap: widget.onPostTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 5
        ),
        padding: const EdgeInsets.all(20),
        decoration: buildBoxDecoration(context),
        child: buildContent(
          context,
          likedByCurrentUser,
          likeCount,
          commentsCount
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.colorScheme.secondary,
      borderRadius: BorderRadius.circular(8),
    );
  }

  Column buildContent(
    BuildContext context,
    bool likedByCurrentUser,
    int likeCount,
    int commentsCount
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTopSection(context),
        const SizedBox(height: 20),
        buildPostMessageContent(context),
        const SizedBox(height: 20),
        buildLikePostContent(likedByCurrentUser, likeCount, commentsCount),
      ],
    );
  }

  Widget buildLikePostContent(
    bool likedByCurrentUser,
    int likeCount,
    int commentsCount
  ) {
    return Row(
      children: [
        likeSection(likedByCurrentUser, likeCount),
        commentsSection(commentsCount),
      ],
    );
  }
    Widget likeSection(
        bool likedByCurrentUser,
        int likeCount
    ) {
      return SizedBox(
          width: 60,
          child: Row(children: [
            GestureDetector(
              onTap: toggleLikePost,
              child: likedByCurrentUser ?
              Icon(Icons.favorite, color: Colors.red,) :
              Icon(Icons.favorite_border, color: context.colorScheme.primary),
            ),
            const SizedBox(width: 5),
            Text(
                likeCount != 0 ? likeCount.toString() : '',
                style: TextStyle(color: context.colorScheme.primary)
            )
          ])
      );
  }

  Widget commentsSection(int commentsCount) {
    return Row(children: [
      GestureDetector(
        onTap: openNewCommentBox,
        child: Icon(Icons.comment, color: context.colorScheme.primary)
      ),
      const SizedBox(width: 5),
      Text(
        commentsCount != 0 ? commentsCount.toString() : '',
        style: TextStyle(color: context.colorScheme.primary)
      )
    ]);
  }

  void toggleLikePost() async {
    try {
      await databaseProvider.toggleLike(widget.post.id);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  final commentController = TextEditingController();

  void openNewCommentBox() async {
    showDialog(
      context: context,
      builder: (context) => AlertBox(
        textController: commentController,
        hintText: "Type a comment...",
        onPressed: () async {
          await addComment();
        },
        onPressedText: "Post"
      )
    );
  }

  Future<void> addComment() async {
    if (commentController.text.trim().isEmpty) return;
    try {
      await databaseProvider
          .addComment(widget.post.id, commentController.text.trim());
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> loadComments() async {
    await databaseProvider.loadComments(widget.post.id);

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
          buildPostUsername(context),
          const Spacer(),
          buildMoreButtonView()
        ],
      ),
    );
  }

  GestureDetector buildMoreButtonView() {
    return GestureDetector(
        onTap: () => showOptions(),
        child: Icon(
          Icons.more_horiz,
          color: context.colorScheme.primary,
        )
    );
  }

  void showOptions() {
    String currentUid = AuthService().getCurrentUid();
    final bool isOwnPost = widget.post.uid == currentUid;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return bottomSheetContent(isOwnPost);
        }
    );
  }

  SafeArea bottomSheetContent(bool isOwnPost) {
    return SafeArea(
      child: Wrap(
        children: [
          if (isOwnPost)
            deleteTile()
          else ...[
            reportTile(),
            blockTile(),
          ],
          cancelTile()
        ],
      ),
    );
  }

  ListTile blockTile() {
    return ListTile(
      leading: const Icon(Icons.block),
      title: const Text("Block User"),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  ListTile reportTile() {
    return ListTile(
      leading: const Icon(Icons.flag),
      title: const Text("Report"),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  ListTile cancelTile() {
    return ListTile(
      leading: const Icon(Icons.cancel),
      title: const Text("Cancel"),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  ListTile deleteTile() {
    return ListTile(
      leading: const Icon(Icons.delete),
      title: const Text("Delete"),
      onTap: () async {
        Navigator.pop(context);
        await databaseProvider.deletePost(widget.post.id);
      },
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
