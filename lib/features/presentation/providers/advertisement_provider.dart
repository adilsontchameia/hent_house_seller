import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hent_house_seller/core/factories/dialogs.dart';
import 'package:hent_house_seller/features/data/models/advertisement_model.dart';
import 'package:hent_house_seller/features/presentation/sale_detail/sale_details.dart';
import 'package:hent_house_seller/features/services/auth_service.dart';
import 'package:uuid/uuid.dart';

class HomeAdsServiceProvider extends ChangeNotifier {
  //? Firebase
  final CollectionReference _adsRef =
      FirebaseFirestore.instance.collection('ads');

  final CollectionReference _sellerRef =
      FirebaseFirestore.instance.collection('sellers');

  final AuthService _authService = AuthService();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<String> downloadUrls = [];

  final ShowAndHideDialogs _dialogs = ShowAndHideDialogs();
  //? Get all ads
  Stream<List<AdvertisementModel>> getAllAds() {
    final currentUser = _authService.getUser();

    final ref = FirebaseFirestore.instance.collection('sellers');
    final userDocRef = ref.doc(currentUser.uid);

    return userDocRef.collection('ads').snapshots().map((querySnapshot) {
      List<AdvertisementModel> sales = [];
      for (var document in querySnapshot.docs) {
        AdvertisementModel sale = AdvertisementModel.fromJson(document.data());
        sales.add(sale);
      }
      return sales;
    });
  }

  Future<AdvertisementModel> getAdsById(String id) async {
    DocumentSnapshot document = await _adsRef.doc(id).get();

    if (document.exists) {
      AdvertisementModel advertisementModel =
          AdvertisementModel.fromJson(document.data() as Map<String, dynamic>);
      return advertisementModel;
    }

    return AdvertisementModel();
  }

  Future<void> createAds(
    String title,
    String address,
    String additionalDescription,
    int bathRoom,
    int bedRooms,
    int kitchen,
    int livingRoom,
    bool electricity,
    bool yard,
    bool water,
    String type,
    String contact,
    double monthlyPrice,
    String sellerName,
    String province,
    double latitude,
    double longitude,
    List<File> image,
  ) async {
    try {
      _dialogs.showProgressIndicator();
      final currentUser = _authService.getUser();
      final adsId = const Uuid().v1();
      await _uploadImages(image).then((url) async {
        final currentDate = DateTime.now();
        final ads = AdvertisementModel(
          id: '',
          title: title,
          sellerId: currentUser.uid,
          address: address,
          additionalDescription: additionalDescription,
          bathRoom: bathRoom,
          bedRooms: bedRooms,
          kitchen: kitchen,
          livingRoom: livingRoom,
          electricity: electricity,
          yard: yard,
          water: water,
          type: type,
          contact: contact,
          publishedDate: currentDate,
          monthlyPrice: monthlyPrice,
          sellerName: sellerName,
          province: province,
          latitude: latitude,
          longitude: longitude,
          isPromo: false,
          image: downloadUrls,
        );

        //Upload inside sellers collection upon ads subcollection
        final userDocRef = _sellerRef.doc(currentUser.uid);
        await userDocRef.collection('ads').doc(adsId).set(ads.toJson());
        //Upload inside ads collection
        await _adsRef.doc(adsId).set(ads.toJson());
        // Update last message for the current user
        updateAdsId(adsId: adsId); //ads collection
        updateAdsId(currentUser: currentUser.uid, adsId: adsId);
        //(collection) users => doc(userId) => (collection)ads
      });

      _dialogs.disposeProgressIndicator();
      //Get.off(() => const BottomNavigationScreens());
    } catch (e) {
      _dialogs.disposeProgressIndicator();
      _dialogs.showToastMessage(e.toString());
    }
    notifyListeners();
  }

  Future<CollectionReference<Map<String, dynamic>>?> updateAdsId({
    String? currentUser,
    String? adsId,
  }) async {
    await FirebaseFirestore.instance.collection('ads').doc(adsId).update({
      'id': adsId,
    });

    await FirebaseFirestore.instance
        .collection('sellers')
        .doc(currentUser)
        .collection('ads')
        .doc(adsId)
        .update({
      'id': adsId,
    });
    return null;
  }

  Future<List<String>> _uploadImages(List<File> images) async {
    final imgName = DateTime.now();
    try {
      for (var img in images) {
        final imgRef = _storage.ref('ads/$imgName');
        await imgRef.putFile(img);

        final imageUrl = await imgRef.getDownloadURL();
        downloadUrls.add(imageUrl);
        log('DownloadUrl Manager: $imageUrl');
      }
    } catch (e) {
      log('Upload: $e');
    }

    return downloadUrls;
  }
}
