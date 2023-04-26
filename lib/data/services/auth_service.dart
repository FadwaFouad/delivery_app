import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  //FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  //SIGN UP METHOD
  Future<String?> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // // update name
      // User? user = result.user;
      // await user?.updateDisplayName(name);
      // await user?.reload();
      return "Signed";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
