import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/alert_box.dart';
import 'package:social_app/components/bio_box.dart';
import 'package:social_app/components/post_tile.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/utils/context_theme_ext.dart';

import '../models/post.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({
    super.key,
    required this.uid
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final databaseProvider =
    Provider.of<DatabaseProvider>(context, listen: false);

  late final listeningProvider =
    Provider.of<DatabaseProvider>(context, listen: true);

  UserProfile? user;
  String currentUserId = AuthService().getCurrentUid();
  bool _isLoading = true;
  final bioTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    user = await databaseProvider.userProfile(widget.uid);
    setState(() {
      _isLoading = false;
    });
  }

  void _showEditBioBox() {
    showDialog(
      context: context,
      builder: (context) => AlertBox(
        textController: bioTextController,
        hintText: "Edit bio",
        onPressed: saveBio,
        onPressedText: "Save"
      )
    );
  }

  Future<void> saveBio() async {
    setState(() {
      _isLoading = true;
    });
    await databaseProvider.updateBio(bioTextController.text);
    await loadUser();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = listeningProvider.filterUserPosts(widget.uid);
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(_isLoading ? '' : user!.name),
        foregroundColor: context.colorScheme.primary,
      ),
      body: buildListView(context, posts),
    );
  }

  ListView buildListView(
      BuildContext context,
      List<Post> posts
  ) {
    return ListView(
      children: [
        buildUsernameView(context),
        const SizedBox(height: 25),
        buildProfileView(context),
        buildEditBioBoxView(context),
        const SizedBox(height: 10),
        BioBox(text: _isLoading ? '...' : user!.bio),
        buildPostsSectionTitle(context),
        buildPostList(posts)
      ],
    );
  }

  Widget buildPostsSectionTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, bottom: 5),
      child: Text(
        "Posts",
        style: TextStyle(
          color: context.colorScheme.primary
        )
      ),
    );
  }

  Widget buildPostList(List<Post> posts) {
    return posts.isEmpty
        ? buildEmptyPostView()
        : buildPostListContent(posts);
  }

  ListView buildPostListContent(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostTile(post: post);
      },
    );
  }

  Center buildEmptyPostView() => const Center(
    child: Text("No posts yet...")
  );

  Widget buildEditBioBoxView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: buildEditBioBoxContent(context),
    );
  }

  Row buildEditBioBoxContent(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildBioBoxTitle(context),
          buildBioBoxGestureDetector(context),
        ],
      );
  }

  GestureDetector buildBioBoxGestureDetector(BuildContext context) {
    return GestureDetector(
          onTap: _showEditBioBox,
          child: Icon(
            Icons.settings,
            color: context.colorScheme.primary,
          ),
        );
  }

  Text buildBioBoxTitle(BuildContext context) {
    return Text(
          "Bio",
          style: TextStyle(
            color: context.colorScheme.primary
          ),
        );
  }

  Center buildProfileView(BuildContext context) {
    return Center(
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.all(25),
          child: Icon(
            Icons.person,
            size: 72,
            color: context.colorScheme.primary,
          ),
        ),
      );
  }

  Center buildUsernameView(BuildContext context) {
    return Center(
        child: Text(
          _isLoading ? '' : '@${user!.username}',
          style: TextStyle(
            color: context.colorScheme.primary
          ),
        )
      );
  }
}
