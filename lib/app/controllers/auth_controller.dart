import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void login() async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      );
      isLoading.value = false;
      print(userCredential);

      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      print(e.code);
    }
  }

  void signup() {
    // Implement signup logic if needed
  }
}
