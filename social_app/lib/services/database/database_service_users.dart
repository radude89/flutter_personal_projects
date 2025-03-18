import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:social_app/services/database/database_service.dart';

import '../../models/user.dart';

extension DatabaseServiceExtension on DatabaseService {
  Future<void> saveUserInfoFirebase({
    required String name,
    required String email
  }) async {
    String uid = auth.currentUser!.uid;
    String username = email.split('@')[0];
    UserProfile user = UserProfile(
        uid: uid,
        name: name,
        email: email,
        username: username,
        bio: ''
    );
    final userMap = user.toMap();
    await db.collection("Users").doc(uid).set(userMap);
  }

  Future<UserProfile?> getUserFromFirebase(String uid) async {
    try {
      DocumentSnapshot userDoc = await db.collection("Users").doc(uid).get();
      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}