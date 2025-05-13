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
          id: '', // firebase will auto generate this
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
}