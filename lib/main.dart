import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app/routes/app_pages.dart';
import 'tema.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Replace with your authentication logic to check if the user is logged in
  User? user = FirebaseAuth.instance.currentUser;

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: user != null ? Routes.HOME : Routes.LOGIN,
      // initialRoute: Routes.PERSETUJUAN,

      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      getPages: AppPages.routes,
    ),
  );
}
