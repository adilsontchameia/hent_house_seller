import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hent_house_seller/app/my_app.dart';
import 'package:hent_house_seller/core/utils.dart';
import 'package:hent_house_seller/features/presentation/providers/advertisement_provider.dart';
import 'package:hent_house_seller/features/presentation/providers/user_data_provider.dart';
import 'package:hent_house_seller/features/presentation/providers/user_provider.dart';
import 'package:hent_house_seller/features/services/user_manager.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Prevent from landscape
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeAdvertisementProvider>(
          create: (_) => HomeAdvertisementProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<AppUtilsProvider>(
          create: (_) => AppUtilsProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<UserAuthProvider>(
          create: (_) => UserAuthProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<UserManager>(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider<UserDataProvider>(
          create: (_) => UserDataProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    ),
  );
}
