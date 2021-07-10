import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _signIn = GoogleSignIn();


  static Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await _signIn.signIn();
    try {
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      return await _auth.signInWithCredential(credential).then(
            (credential) => credential.user,
      );
    } catch (error) {
      return null;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
    _signIn.disconnect();
  }

  static Future<User?> getSignedInUser() async {
    if (_auth.currentUser != null) return _auth.currentUser;

    final GoogleSignInAccount? gUser = await _signIn.signInSilently();
    try {
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      return await _auth.signInWithCredential(credential).then(
            (credential) => credential.user,
      );
    } catch (error) {
      return null;
    }
  }
}