import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/services/database/database_service.dart';
import 'package:social_app/services/database/database_service_comments.dart';
import 'package:social_app/services/database/database_service_posts.dart';
import 'package:social_app/services/database/database_service_update_bio.dart';
import 'package:social_app/services/database/database_service_users.dart';

import '../../models/comment.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();
  final _auth = AuthService();

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
    initializeLikeMap();
    notifyListeners();
  }

  List<Post> filterUserPosts(String uid) {
    return _allPosts.where((post) => post.uid == uid).toList();
  }

  Future<void> deletePost(String postId) async {
    await _db.deletePostFromFirebase(postId);
    await loadAllPosts();
  }

  Map<String, int> _likeCounts = {};
  List<String> _likedPosts = [];
  bool isPostLikedByCurrentUser(String postId) => _likedPosts.contains(postId);
  int getLikeCount(String postId) => _likeCounts[postId] ?? 0;

  void initializeLikeMap() {
    final currentUserID = _auth.getCurrentUid();
    _likedPosts.clear();
    for (var post in _allPosts) {
      _likeCounts[post.id] = post.likeCount;
      if (post.likedBy.contains(currentUserID)) {
        _likedPosts.add(post.id);
      }
    }
  }

  Future<void> toggleLike(String postId) async {
    final likedPostsOriginal = _likedPosts;
    final likedCountsOriginal = _likeCounts;
    if(_likedPosts.contains(postId)) {
      _likedPosts.remove(postId);
      _likeCounts[postId] = (_likeCounts[postId] ?? 0) - 1;
    } else {
      _likedPosts.add(postId);
      _likeCounts[postId] = (_likeCounts[postId] ?? 0) + 1;
    }
    notifyListeners();
    try {
      await _db.toggleLikeInFirebase(postId);
    } catch (e) {
      _likedPosts = likedPostsOriginal;
      _likeCounts = likedCountsOriginal;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  final Map<String, List<Comment>> _comments = {};
  List<Comment> getComments(String postId) => _comments[postId] ?? [];

  Future<void> loadComments(String postId) async {
    final allComments = await _db.getCommentsFromFirebase(postId);
    _comments[postId] = allComments;
    notifyListeners();
  }

  Future<void> addComment(String postId, message) async {
    await _db.addCommentInFirebase(postId, message);
    await loadComments(postId);
  }

  Future<void> deleteComment(String commentId, postId) async {
    await _db.deleteCommentInFirebase(commentId);
    await loadComments(postId);
  }

}