import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/database/database_service_users.dart';

import 'database_service.dart';

extension DatabaseServiceExtension on DatabaseService {
  Future<void> postMessageInFirebase(String message) async {
    try {
      String uid = auth.currentUser!.uid;
      UserProfile? user = await getUserFromFirebase(uid);
      Post newPost = Post(
          id: '',
          // firebase will auto generate this
          uid: uid,
          name: user!.name,
          username: user.username,
          message: message,
          timestamp: Timestamp.now(),
          likeCount: 0,
          likedBy: []
      );
      Map<String, dynamic> newPostMap = newPost.toMap();
      await db.collection("Posts").add(newPostMap);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<Post>> getAllPostsFromFirebase() async {
    try {
      QuerySnapshot snapshot = await db
          .collection("Posts")
          .orderBy('timestamp', descending: true)
          .get();
      return snapshot.docs.map(
              (doc) => Post.fromDocument(doc)
      ).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  Future<void> deletePostFromFirebase(String postId) async {
    try {
      await db.collection("Posts").doc(postId).delete();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> toggleLikeInFirebase(String postId) async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentReference postDoc = db.collection("Posts").doc(postId);
      await db.runTransaction((transaction) async {
        DocumentSnapshot postSnapshot = await transaction.get(postDoc);
        List<String> likedBy = List<String>
            .from(postSnapshot['likedBy'] ?? []);
        int currentLikeCount = postSnapshot['likes'];
        if (!likedBy.contains(uid)) {
          likedBy.add(uid);
          currentLikeCount++;
        } else {
          likedBy.remove(uid);
          currentLikeCount--;
        }
        transaction.update(postDoc, {
          'likes': currentLikeCount,
          'likedBy': likedBy,
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}