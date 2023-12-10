import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/utils/keys.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // * : Register User
  Future<String> registerUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      
      res = correctKey;
    } on FirebaseAuthException catch (err) {
      res = err.toString();
    }

    return res;
  }
}