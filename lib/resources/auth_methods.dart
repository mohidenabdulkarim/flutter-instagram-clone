import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error has occurred!";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register auth user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(credential.user);

        //register user in DB.
        await _firestore
            .collection("users")
            .doc(
              credential.user!.uid,
            )
            .set({
          'username': username,
          'uid': credential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': []
        });
        res = "success";
      }
      return res;
    } catch (e) {
      res = e.toString();
      return res;
    }
  }
}
