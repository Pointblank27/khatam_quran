import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC =
      TextEditingController(text: "ihank.ganteng05@gmail.com");
  TextEditingController passC = TextEditingController(text: "12345678");

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );

      print(userCredential);

      isLoading.value = false;
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      print("Firebase Authentication Error: ${e.code}");
      print("Error Message: ${e.message}");
    }
  }
}
