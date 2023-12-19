import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class DataMengajiController extends GetxController {
  TextEditingController captionC = TextEditingController();
  TextEditingController juzC = TextEditingController();
  TextEditingController surahC = TextEditingController();
  TextEditingController ayatC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String? uid = auth.currentUser?.uid;
      if (uid != null) {
        DocumentSnapshot<Map<String, dynamic>> docUser =
            await firestore.collection("users").doc(uid).get();
        if (docUser.exists) {
          return docUser.data();
        } else {
          print("User document does not exist.");
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  var mediaPath = ''.obs;
  var mediaType = ''.obs;

  Future<void> pickMedia() async {
    final ImagePicker picker = ImagePicker();
    final XFile? media = await picker.pickMedia();

    if (media != null) {
      setMediaPath(media.path);

      if (media.path.toLowerCase().endsWith('.mp4')) {
        mediaType.value = 'video';
      } else {
        mediaType.value = 'image';
      }
    }
  }

  void setMediaPath(String path) {
    mediaPath.value = path;
  }

  Future<void> upload() async {
    try {
      await Firebase.initializeApp();

      if (mediaPath.value.isNotEmpty) {
        final Reference storageRef =
            FirebaseStorage.instance.ref().child('posts/${DateTime.now()}');
        final UploadTask uploadTask = storageRef.putFile(File(mediaPath.value));

        await uploadTask.whenComplete(() async {
          final mediaUrl = await storageRef.getDownloadURL();

          final user = FirebaseAuth.instance.currentUser;

          final postId =
              FirebaseFirestore.instance.collection('posts').doc().id;

          // Retrieve the values from the text input fields
          final juz = juzC.text;
          final surah = surahC.text;
          final ayat = ayatC.text;

          await FirebaseFirestore.instance.collection('posts').doc(postId).set({
            'postId': postId,
            'mediaUrl': mediaUrl,
            'mediaType': mediaType.value,
            'userId': user?.uid,
            'juz': juz, // Add the juz field
            'surah': surah, // Add the surah field
            'ayat': ayat, // Add the ayat field
            'create_at': DateTime.now().toIso8601String()
          });

          Get.snackbar("Success", "Media successfully uploaded");
          Get.offAllNamed(Routes.HOME);
        });
      } else {
        Get.snackbar("Failed", "No media selected");
      }
    } catch (error) {
      Get.snackbar("Failed", "Error uploading media: $error");
    }
  }
}
