import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scheduler/Templates/GoogleAssets.dart';

class Google {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAuthentication googleAccount;
  FirebaseUser firebaseUser;

  Future<GoogleAssets> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    googleAccount = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAccount.accessToken,
      idToken: googleAccount.idToken,
    );

    firebaseUser = await _auth.signInWithCredential(credential);

    return GoogleAssets(googleAccount, firebaseUser);
  }

  Future<void> handleSignOut() async {
    this.firebaseUser = null;
    this.googleAccount = null;

    this._googleSignIn.signOut();
    this._auth.signOut();
  }
}
