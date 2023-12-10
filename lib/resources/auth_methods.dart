import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/utils/keys.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // * : Is User Detail Present or Not
  Future<String> isUserDetailPresent({
    required String whichCollectionKey,
    required String fromWhichKey,
    required String whichDetail,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(whichCollectionKey)
      .where(fromWhichKey, isEqualTo: whichDetail)
      .get();

      if(querySnapshot.docs.isNotEmpty) {
        return correctKey;
      } else {
        return inCorrectKey;
      }
    } catch (err) {
      return err.toString();
    }
  }

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