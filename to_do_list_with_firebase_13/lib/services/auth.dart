import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _myFirebaseExample = FirebaseAuth.instance;

  Future<UserCredential> signInAnonymously() async {
    return _myFirebaseExample.signInAnonymously();
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential user = await _myFirebaseExample.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _myFirebaseExample.signInWithCredential(credential);
  }

  Future<User?> createNewUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential user = await _myFirebaseExample
        .createUserWithEmailAndPassword(email: email, password: password);
    return user.user;
  }

  Future<void> signOut() async {
    await _myFirebaseExample.signOut();
    await GoogleSignIn().signOut();

  }

  Stream<User?> userSituation() {
    return _myFirebaseExample
        .authStateChanges(); // kullanıcının login - out durumu
  }
}
