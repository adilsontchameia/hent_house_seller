import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hent_house_seller/features/data/models/advertisement_model.dart';
import 'package:hent_house_seller/features/data/models/seller_model.dart';
import 'package:hent_house_seller/features/presentation/sale_detail/sale_details.dart';

class UserManager extends ChangeNotifier {
  //? Firebase
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _sellerRef =
      FirebaseFirestore.instance.collection('sellers');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late final FirebaseAuth _firebaseAuth;

  UserManager() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  void isWriting() {
    _sellerRef.doc(getUser().uid).update({'isTyping': true});
  }

  void isNotWriting() {
    _sellerRef.doc(getUser().uid).update({'isTyping': false});
  }

  void setUserState(bool isOnline) {
    _sellerRef.doc(getUser().uid).update({'isOnline': isOnline});
  }

  //? Create User - Create User Info On Firebase Firestore
  Future<void> createSeller(SellerModel seller) async {
    try {
      await _ref.doc(seller.id).set(seller.toJson());
      await _sellerRef.doc(seller.id).set(seller.toJson());
    } on FirebaseException catch (e) {
      log('Create Error: ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> createAds(AdvertisementModel seller) async {
    try {
      return await _ref.doc(seller.id).set(seller.toJson());
    } on FirebaseException catch (e) {
      log('Create Error: ${e.toString()}');
    }
    notifyListeners();
  }

  //? Get Current User
  User getUser() {
    notifyListeners();
    return _firebaseAuth.currentUser!;
  }

  //? Get Seller By ID
  Stream<SellerModel> getUserById(String id) {
    notifyListeners();
    return _ref.doc(id).snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return SellerModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>,
        );
      } else {
        // Return null if the document doesn't exist
        return SellerModel();
      }
    });
  }

  Stream<SellerModel> getSellerById(String id) {
    notifyListeners();
    return _ref.doc(id).snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return SellerModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>,
        );
      } else {
        // Return null if the document doesn't exist
        return SellerModel();
      }
    });
  }

  //? Update user device token
  Future<void> updateData(Map<String, dynamic> data, String id) async {
    return _ref.doc(id).update(data);
  }

  Future<String> uploadPicture(String filePath, String? imageName) async {
    XFile file = XFile(filePath);

    try {
      await _storage.ref('profilePics/$imageName').putFile(File(file.path));
    } on FirebaseException catch (e) {
      log('Upload: $e');
    }

    String downloadUrl =
        await _storage.ref('profilePics/$imageName').getDownloadURL();
    log('DownloadUrl Manager: $downloadUrl');
    return downloadUrl;
  }
}
