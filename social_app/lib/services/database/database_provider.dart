import 'package:flutter/cupertino.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/database/database_service.dart';
import 'package:social_app/services/database/database_service_update_bio.dart';
import 'package:social_app/services/database/database_service_users.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();

  Future<UserProfile?> userProfile(String uid) =>
      _db.getUserFromFirebase(uid);

  Future<void> updateBio(String bio) =>
      _db.updateUserBioInFirebase(bio);
}