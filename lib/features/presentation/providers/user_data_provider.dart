import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hent_house_seller/features/data/models/user_model.dart';

class UserDataProvider extends ChangeNotifier {
  UserModel _currentUser = UserModel();

  UserModel get currentUser => _currentUser;

  void setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  getCurrentUserData() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);

      try {
        final userSnapshot = await userDoc.get();

        if (userSnapshot.exists) {
          UserModel user = UserModel.fromJson(userSnapshot.data()!);
          setCurrentUser(user);
        } else {
          // Handle the case when the user document doesn't exist
        }
      } catch (e) {
        // Handle any errors that occurred while fetching data
        log('Error fetching user data: $e');
      }
    }
  }
}
