import 'package:firebase_auth/firebase_auth.dart';

enum FirebaseJoinError {
  emailAlreadyInUseError,
  invalidEmailError,
  operationNotAllowedError,
  weakPasswordError,
  etcError,
}

class FirebaseService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<String> join(String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return credential.user!.uid;
      } else {
        throw Exception("Server error");
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          throw FirebaseJoinError.emailAlreadyInUseError;
        case "invalid-email":
          throw FirebaseJoinError.invalidEmailError;
        case "operation-not-allowed":
          throw FirebaseJoinError.operationNotAllowedError;
        case "weak-password":
          throw FirebaseJoinError.weakPasswordError;
        default:
          throw FirebaseJoinError.etcError;
      }
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return credential.user!.uid;
      } else {
        throw Exception("Server error");
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
}
