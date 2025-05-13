import 'package:flutter/foundation.dart';
import 'package:social_app/services/auth/auth_service.dart';

import 'database_service.dart';

extension DatabaseServiceExtension on DatabaseService {
  Future<void> updateUserBioInFirebase(String bio) async {
    String uid = auth.currentUser!.uid;
    try {
      await db.collection("Users").doc(uid).update({
        "bio": bio,
      });
    }
    catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}