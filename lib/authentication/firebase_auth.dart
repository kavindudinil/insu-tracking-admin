import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insu_tracking_admin/provider/user_provider.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserProvider provider = UserProvider();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<User?> signInIP() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if(googleSignInAccount != null ){
        final GoogleSignInAuthentication googleSignInAuthentication = await
        googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential credentialIP = await _firebaseAuth.signInWithCredential(credential);
        await saveUser(googleSignInAccount);
        return credentialIP.user;
      }

    }catch(e) {
      print("some error occured $e");
    }
    return null;
  }

  Future<void> saveUser(GoogleSignInAccount account) async {
    await FirebaseFirestore.instance.collection('admin').doc(account.id).set({
      'id': account.id,
      'name': account.displayName,
      'email': account.email,
      'photoUrl': account.photoUrl,
    });
    UserProvider.instance.updateUserInfo(
        id: account.id,
        email: account.email,
        photoUrl: account.photoUrl,
        username: account.displayName);
    print("User saved");
  }



  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}