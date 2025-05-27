import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/alert_box.dart';
import 'package:social_app/components/default_drawer.dart';
import 'package:social_app/components/post_tile.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/utils/context_theme_ext.dart';

import '../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final messageController = TextEditingController();

  late final databaseProvider = Provider
      .of<DatabaseProvider>(context, listen: false);

  late final listeningProvider = Provider
      .of<DatabaseProvider>(context, listen: true);

  void openPostMessageBox() {
    showDialog(
      context: context,
      builder: (context) => AlertBox(
        textController: messageController,
        hintText: "What's on your mind?",
        onPressed: () async {
          await postMessage(messageController.text);
        },
        onPressedText: "Post"
      ),
    );
  }

  Future<void> postMessage(String message) async {
    await databaseProvider.postMessage(message);
  }

  Future<void> loadAllPosts() async {
    await databaseProvider.loadAllPosts();
  }

  @override
  void initState() {
    super.initState();
    loadAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      drawer: DefaultDrawer(),
      appBar: AppBar(
        title: const Text("Home"),
        foregroundColor: context.colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openPostMessageBox,
        child: const Icon(Icons.add),
      ),
      body: buildPostList(listeningProvider.allPosts),
    );
  }

  Widget buildPostList(List<Post> posts) {
    return posts.isEmpty
        ? const Center(child: Text("Nothing here..."))
        : buildListView(posts);
  }

  ListView buildListView(List<Post> posts) {
    return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      final post = posts[index];
      return PostTile(post: post);
    },
  );
  }
}
