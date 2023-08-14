import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hent_house_seller/features/presentation/login/login_screen.dart';
import 'package:hent_house_seller/features/presentation/onboard/onboard_screen.dart';
import 'package:hent_house_seller/features/presentation/request_permission/request_permission.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckAuthScreen extends StatefulWidget {
  static const routeName = '/check-screen';
  const CheckAuthScreen({super.key});

  @override
  State<CheckAuthScreen> createState() => _CheckAuthScreenState();
}

class _CheckAuthScreenState extends State<CheckAuthScreen> {
  Future<void> _check() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      final hasAccess = await Permission.locationWhenInUse.isGranted;
      //log(user!.email.toString());
      if (!hasAccess) {
        Get.to(() => const RequestPermissionScreen());
      } else if (user == null) {
        Get.to(() => const LoginScreen());
      } else {
        Get.to(() => OnboardScreen());
      }
    });
  }

  @override
  void initState() {
    scheduleMicrotask(() {
      _check();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.brown,
      )),
    );
  }
}
