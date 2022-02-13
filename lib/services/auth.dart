import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:rain_recorder/models/user.dart';

class AuthService {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  User? _userFromFirebaseUser(fb.User? user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth
        .authStateChanges()
        .map((fb.User? user) => _userFromFirebaseUser(user!)!);
  }

  Future signInAnon() async {
    try {
      fb.UserCredential result = await _auth.signInAnonymously();
      fb.User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      fb.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      fb.User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      fb.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      fb.User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
