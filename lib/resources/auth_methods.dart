import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:instagram/utils/keys.dart';
import 'package:instagram/models/users.dart' as model;

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // * : Is User Detail Present or Not
  Future<String> isUserDetailPresent({
    required String whichCollectionKey,
    required String fromWhichKey,
    required String toWhichDetail,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(whichCollectionKey)
      .where(fromWhichKey, isEqualTo: toWhichDetail)
      .get();

      if(querySnapshot.docs.isEmpty) {
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

  // * : SignUp User
  Future<String> signUpUser({
    required Uint8List profileImage,
    required String userName,
    required String emailAddress
  }) async {
    String res = "Some error occured";
    try {
      String uid = _auth.currentUser!.uid;

      // * : Get photo url from firebase storage
      String photoUrl = await StorageMethods().uploadImageToStorage(profileImageChildKey, profileImage, false);

      model.User user = model.User(
        uid : uid,
        fullName : "",
        birthday : "",
        gender : "",
        bio : "",
        profileImageUrl : photoUrl,
        username : userName,
        emailAddress : emailAddress,
        followers : [],
        following : [],
      );

      // * : Add User to users collection
      await FirebaseFirestore.instance
      .collection(usersCollectionKey)
      .doc(uid)
      .set(user.toJson());

      res = correctKey;
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // * : SignIn User
  Future<String> signInUser({
    required String emailAddress,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if(emailAddress.isNotEmpty || password.isNotEmpty){

        // * : Signing in User with email
        await _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
        res = correctKey;
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // * : Reset Password
  Future<String> resetPassword({
    required String email
  }) async {
    String res = "Some error occured";

    try{
      await _auth.sendPasswordResetEmail(email: email);
      res = correctKey;
    } on FirebaseAuthException catch(err) {
      res = err.toString();
    }

    return res;
  }
}