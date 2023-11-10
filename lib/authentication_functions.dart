import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthFunctions{

  final storage = const FlutterSecureStorage();
  final _firebase = FirebaseAuth.instance;
  signUpUser(email,pass)async{
    log('signUp Started');
    await _firebase.createUserWithEmailAndPassword(email: email, password: pass);
    log('signUp Ended');
  }

  loginUser(email,pass)async{
      log('started login');
      UserCredential cred = await _firebase.signInWithEmailAndPassword(email: email, password: pass);
      UserModel user = UserModel(name: "prajjwal", uid: cred.user?.uid);
      storage.write(key: 'uid', value: cred.user?.uid);
      return user;
  }

  signOutUser() async {
       await _firebase.signOut();
       await storage.deleteAll();
  }
  signInWithGoogle()
  async {
    GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;
    AuthCredential credential= GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );
    UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
    UserModel myUser = UserModel(name: user.user?.displayName, uid: user.user?.uid);
    storage.write(key: 'uid', value: user.user?.uid);
    return myUser;
  }

}