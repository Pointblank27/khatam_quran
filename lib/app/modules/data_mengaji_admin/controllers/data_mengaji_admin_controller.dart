import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';

class DataMengajiAdminController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<Map<String, dynamic>?> getData() async {
    try {
      String? uid = auth.currentUser?.uid;
      if (uid != null) {
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
            .collection("posts")
            .where("status", isEqualTo: "pending")
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.first.data();
        } else {
          print("User document does not exist.");
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  void accept(String? postId) async {
    if (postId != null) {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId) // Use doc() instead of where()
          .set({
        "status": "accept",
      }, SetOptions(merge: true));
    }
  }

  void reject(String? postId) async {
    if (postId != null) {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId) // Use doc() instead of where()
          .set({
        "status": "reject",
      }, SetOptions(merge: true));
    }
  }
}
