import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/auth_service.dart';

final authProvider = Provider<Authentication>((ref) {
  return Authentication();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authProvider).authStateChange;
});

// final signInProvider = FutureProvider<String?>((ref, email, pass) {
//   return ref.read(authProvider).signIn();
// });