import 'package:firebase_auth/firebase_auth.dart';
class FireBaseAuthServices{
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      print('Bazi hatalar var');
    }
    return null;
  }
  Future<User?> signInEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      print('Bazi hatalar var');
    }
    return null;
  }
  Future<User?> signOut()async{
    await _auth.signOut();
  }

}