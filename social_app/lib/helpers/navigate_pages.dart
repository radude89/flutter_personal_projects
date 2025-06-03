
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../pages/post_page.dart';
import '../pages/profile_page.dart';

void goToUserPage(BuildContext context, String uid) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfilePage(uid: uid),
    ),
  );
}

void goToPostsPage(BuildContext context, Post post) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PostPage(post: post),
    ),
  );
}