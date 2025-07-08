import 'package:flutter/cupertino.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/database/database_service.dart';
import 'package:social_app/services/database/database_service_posts.dart';
import 'package:social_app/services/database/database_service_update_bio.dart';
import 'package:social_app/services/database/database_service_users.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();

  Future<UserProfile?> userProfile(String uid) =>
      _db.getUserFromFirebase(uid);

  Future<void> updateBio(String bio) =>
      _db.updateUserBioInFirebase(bio);

  List<Post> _allPosts = [];
  List<Post> get allPosts => _allPosts;

  Future<void> postMessage(String message) async {
    await _db.postMessageInFirebase(message);
    await loadAllPosts();
  }

  Future<void> loadAllPosts() async {
    final allPosts = await _db.getAllPostsFromFirebase();
    _allPosts = allPosts;
    notifyListeners();
  }

  List<Post> filterUserPosts(String uid) {
    return _allPosts.where((post) => post.uid == uid).toList();
  }

  Future<void> deletePost(String postId) async {
    await _db.deletePostFromFirebase(postId);
    await loadAllPosts();
  }
}