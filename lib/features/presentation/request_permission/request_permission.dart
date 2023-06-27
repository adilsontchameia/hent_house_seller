import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hent_house_seller/features/presentation/login/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionScreen extends StatefulWidget {
  static const routeName = 'request-permission';
  const RequestPermissionScreen({super.key});

  @override
  State<RequestPermissionScreen> createState() =>
      _RequestPermissionScreenState();
}

class _RequestPermissionScreenState extends State<RequestPermissionScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //To check if the permissiona was enabled manually
    WidgetsBinding.instance.addObserver(this);
  }

  bool _fromSettings = false;

  //Need to cloe
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //Resuming from the settings
    if (state == AppLifecycleState.resumed && _fromSettings) {
      _check();
    }
    debugPrint('AppLifecycleState: $state');
  }

  _check() async {
    final hasAccess = await Permission.locationWhenInUse.isGranted;
    if (hasAccess) {
      _goToPage(LoginScreen.routeName);
    }
  }

  Future<void> _goToPage(String page) async {
    await Navigator.pushNamed(context, page);
  }

  _openAppSettings() async {
    await openAppSettings();
    _fromSettings = true;
  }

  Future<void> _request() async {
    final status = await Permission.locationWhenInUse.request();
    debugPrint('Status: $status');
    switch (status) {
      case PermissionStatus.denied:
        if (Platform.isIOS) _openAppSettings();
        if (Platform.isAndroid) showSnackBar('Permission Danied');
        break;
      case PermissionStatus.granted:
        _goToPage(LoginScreen.routeName);
        break;
      case PermissionStatus.restricted:
        showSnackBar('Permission Restricted');
        break;
      case PermissionStatus.limited:
        showSnackBar('Permission Limited');
        break;
      case PermissionStatus.provisional:
        showSnackBar('Permission Provisional');
        break;
      case PermissionStatus.permanentlyDenied:
        _openAppSettings();
        break;
    }
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message,
            style: const TextStyle(fontWeight: FontWeight.bold))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100.0,
              width: 115.0,
              child: Card(
                elevation: 5.0,
                color: Colors.brown,
                child: Center(
                  child: Text(
                    'Mô Cúbico',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Permissão',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'Aplicação precisa acesso a sua localização para melhor experiência às funcionalidades.',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20.0,
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center),
            ),
            GestureDetector(
              onTap: () => _request(),
              child: Container(
                height: 40.0,
                width: 120.0,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Text(
                    'Pemritir',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
