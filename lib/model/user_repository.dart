import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
 FirebaseAuth _auth = FirebaseAuth.instance;
 GoogleSignIn googleSignIn = GoogleSignIn();
 FirebaseUser _user;
  var firebaseAuth = FirebaseAuth.instance;
  Status _status = Status.Uninitialized;

  UserRepository.instance()
      : _auth = FirebaseAuth.instance,
        googleSignIn = GoogleSignIn() {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }



 Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }

  }

  Future<bool> signInWithFB()
  async{
    _status = Status.Authenticating;
    notifyListeners();
    FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
    final accessToken = facebookLoginResult.accessToken.token;
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      final facebookAuthCred =
      FacebookAuthProvider.getCredential(accessToken: accessToken);
      final user =
          await firebaseAuth.signInWithCredential(facebookAuthCred);
      //print("User : " + user.displayName);
      return true;
    } else {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }
 Future<FacebookLoginResult> _handleFBSignIn() async {
   FacebookLogin facebookLogin = FacebookLogin();
   FacebookLoginResult facebookLoginResult =
   await facebookLogin.logInWithReadPermissions(['email']);
   switch (facebookLoginResult.status) {
     case FacebookLoginStatus.cancelledByUser:
       print("Cancelled");
       break;
     case FacebookLoginStatus.error:
       print("error");
       break;
     case FacebookLoginStatus.loggedIn:
       print("Logged In");
       break;
   }
   return facebookLoginResult;
 }

  Future signOut() async {
    _auth.signOut();
    googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

 @override
 Future<void> resetPassword(String email) async {
   _status = Status.Authenticating;
   notifyListeners();
   await _auth.sendPasswordResetEmail(email: email);
 }
}
