import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  //FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  //SIGN UP METHOD
  Future<String?> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // update user name
      User? user = result.user;
      await user?.updateDisplayName(name);
      await user?.reload();

      // save user data in firestore
      saveUserData(name, email);

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

// save data of user
  Future<void> saveUserData(String name, String email) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentReference users = firestore.collection('users').doc(uid);
      await users.set({'name': name, 'email': email});
    }
  }
}
