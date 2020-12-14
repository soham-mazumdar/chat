import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthService {

  AuthService();
  
  Future<User> registerWithCred(String _mail, String _pass) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = (await _auth.createUserWithEmailAndPassword(email: _mail,password: _pass,)).user;
    
    assert(user != null);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    return user;
  } 

  
  Future<User> signInCred(String _mail, String _pass) async {
    // print(email);
    final FirebaseAuth _auth = FirebaseAuth.instance;

    
    final User user = (await _auth.signInWithEmailAndPassword(email: _mail,password: _pass,)).user;
    
    assert(user != null);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    return user;
  } 

  Future<User> signInFb() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
  
    final facebookLogin = FacebookLogin();
    final FacebookLoginResult facebookLoginResult =
        await facebookLogin.logIn(<String>['email', 'public_profile']);
    final FacebookAccessToken myToken = facebookLoginResult.accessToken;
    final AuthCredential credential =
        FacebookAuthProvider.credential(myToken.token);
    final User user =
        (await _auth.signInWithCredential(credential)).user;
    
    return user;
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();

  }

}