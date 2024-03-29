// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBgogaa5FelhTlgQVpZfJWm_JUjYgwQ0M',
    appId: '1:867211967543:android:e3f6fe118976a70c3053b2',
    messagingSenderId: '867211967543',
    projectId: 'homerent-a6208',
    storageBucket: 'homerent-a6208.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAc2D3Nd8QmMuTCHNMv_HcpD2bgd7PQTg8',
    appId: '1:867211967543:ios:d8c3a7a9c89531ce3053b2',
    messagingSenderId: '867211967543',
    projectId: 'homerent-a6208',
    storageBucket: 'homerent-a6208.appspot.com',
    androidClientId: '867211967543-vd09sq3tuibka7602q4isqo12bpni9ej.apps.googleusercontent.com',
    iosClientId: '867211967543-b3c9vai1vhmu07ei76fardnqv49h9mhm.apps.googleusercontent.com',
    iosBundleId: 'com.example.hentHouseSeller',
  );
}
