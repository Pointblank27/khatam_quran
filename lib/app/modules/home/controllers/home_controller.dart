import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';

class HomeController extends GetxController {
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
    return null; // Add this line to handle cases where no value is returned
  }

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isAdmin() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String? uid = user.uid;

        QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: uid)
            .where('admin', isEqualTo: true)
            .get();

        return adminSnapshot.docs.isNotEmpty;
      } else {
        return false;
      }
    } catch (e) {
      // Handle exceptions (e.g., Firebase errors) here
      print("Error in isAdmin: $e");
      return false;
    }
  }
}
