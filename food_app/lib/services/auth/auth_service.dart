import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> signIn(String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential;
    }
    on FirebaseException catch (error) {
      throw Exception(error.code);
    }
  }

  Future<UserCredential> register(String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential;
    }
    on FirebaseException catch (error) {
      throw Exception(error.code);
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}