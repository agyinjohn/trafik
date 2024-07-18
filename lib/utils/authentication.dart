// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:traffic/utils/commons.dart';
import 'package:traffic/utils/models/usermodel.dart';
import 'package:traffic/utils/providers/userprovider.dart';

final authMethodProvider = Provider((ref) => AuthMethods(ref: ref));

class AuthMethods {
  AuthMethods({required this.ref});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final ProviderRef ref;
  Future<bool> signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    bool res = false;
    try {
      res = false;
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _firebaseFirestore
                .collection('users')
                .doc(cred.user!.uid)
                .get();
        if (snapshot.data() != null) {
          UserModel user = UserModel.fromMap(snapshot.data()!);
          ref.read(userProvider.notifier).saveUser(user);

          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool("isAthenticated", true);
        }
      }
      res = true;
    } on FirebaseAuthException catch (e) {
      res = false;
      showSnackBar(context, e.message!);
    } catch (e) {
      res = false;
      showSnackBar(context, e.toString());
      print(e.toString());
    }
    return res;
  }

  Future<bool> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
    required Uint8List profilePic,
  }) async {
    bool res = false;
    try {
      res = false;
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String profileUrl =
          await uploadProfileToStorage(profilePic, credential.user!.uid);

      UserModel user = UserModel(
          name: username,
          email: email,
          id: credential.user!.uid,
          // role: UserRole.user,
          profileUrl: profileUrl);

      _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set(user.toMap());
      res = true;
    } on FirebaseAuthException catch (e) {
      res = false;
      showSnackBar(context, e.message!);
    } catch (e) {
      res = false;
      showSnackBar(context, e.toString());
    }
    return res;
  }

  signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
