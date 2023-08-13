import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hent_house_seller/core/factories/dialogs.dart';
import 'package:hent_house_seller/features/presentation/bottom_navigation_pages/bottom_navigation_screen.dart';
import 'package:hent_house_seller/features/services/auth_service.dart';
import 'package:hent_house_seller/features/services/user_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';

import 'package:permission_handler/permission_handler.dart' as permission;

class UserAuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserManager _userManager = UserManager();

  final ShowAndHideDialogs _dialogs = ShowAndHideDialogs();
  Position? position;
  StreamSubscription? _gpsStatusSubscription;
  //ErrorMessage
  String? error;
  //ShopData
  double? userAddressLatitude;
  double? userAddressLongitude;
  bool permissionAllowed = false;
  String featureName = '';
  String addressLine = '';
  String userAddress = '';
  String? userEmail;
  String? pickedError;
  bool? gpsEnabled;
  //Image Utils
  XFile? fileImage;
  bool isReady = false;

  void init() async {
    final status = await permission.Permission.locationWhenInUse.request();
    if (status == permission.PermissionStatus.granted) {
      await getCurrentLocation();
    }
    _requestGpsPermission();
  }

  @override
  void dispose() {
    super.dispose();
    _gpsStatusSubscription?.cancel();
  }

  Future<void> _requestGpsPermission() async {
    final status = await Permission.locationWhenInUse.request();
    debugPrint('Status: $status');
    switch (status) {
      case PermissionStatus.denied:
        _openAppSettings();
        break;
      case PermissionStatus.granted:
        log('Permission Granted');
        break;
      case PermissionStatus.restricted:
        log('Permission Restricted');
        break;
      case PermissionStatus.limited:
        log('Permission Limited');
        break;
      case PermissionStatus.provisional:
        log('Permission Provisional');
        break;
      case PermissionStatus.permanentlyDenied:
        _openAppSettings();
        break;
    }
  }

  _openAppSettings() async {
    await openAppSettings();
  }

  Future<void> getCurrentLocation() async {
    try {
      await _requestGpsPermission();
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (position != null) {
        userAddressLatitude = position!.latitude;
        userAddressLongitude = position!.longitude;
        final List<Placemark> placemarks = await placemarkFromCoordinates(
          userAddressLatitude!,
          userAddressLongitude!,
        );
        if (placemarks.isNotEmpty) {
          final Placemark placemark = placemarks.first;
          featureName = placemark.name ?? '';
          addressLine = placemark.street ?? '';
          userAddress = '$featureName, $addressLine';
        }
      } else {
        log('Error: Unable to get current location. Position is null.');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

//Register User Using Email
  Future<void> signUp({
    String? firstName,
    String? surnName,
    String? email,
    String? phone,
    String? password,
    String? address,
    var latitude,
    var longitude,
    XFile? image,
  }) async {
    try {
      if (isReady) {
        if (image == null) {
          throw Exception("Image is null");
        }
        //GetImage URL to store to DB
        _dialogs.showProgressIndicator();
        await _userManager
            .uploadPicture(image.path, DateTime.now().toString())
            .then((url) async {
          await _authService.register(
            firstName: firstName,
            surnName: surnName,
            email: email,
            password: password,
            phone: phone,
            address: address,
            latitude: userAddressLatitude,
            longitude: userAddressLongitude,
            image: url,
          );
          await _userManager.createSeller(_authService.user);

          _dialogs.disposeProgressIndicator();
          Get.off(() => const BottomNavigationScreens());
          return url;
        });
      } else {
        _dialogs.disposeProgressIndicator();
        log('Nulo');
      }
    } catch (e) {
      _dialogs.disposeProgressIndicator();
      _dialogs.showToastMessage(e.toString());
    }
    notifyListeners();
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await _authService.login(
        context,
        email,
        password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
        debugPrint(error);
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
        debugPrint(error);
      }
    }
    notifyListeners();
  }

  getGalleryImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
      );

      if (pickedFile != null) {
        fileImage = XFile(pickedFile.path);
      } else {
        pickedError = 'No Image Selected';
        debugPrint(pickedError);
      }
    } catch (e) {
      log('Image: $e');
    }

    notifyListeners();
    return fileImage!;
  }

  getCameraImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 20,
      );

      if (pickedFile != null) {
        fileImage = XFile(pickedFile.path);
      } else {
        pickedError = 'No Image Selected';
      }
    } catch (e) {
      log('Image: $e');
    }

    notifyListeners();
    return fileImage!;
  }
}
