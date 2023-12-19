import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';

class HistoryController extends GetxController {}

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

Future<Map<String, dynamic>?> getData() async {
  try {
    String? uid = auth.currentUser?.uid;
    if (uid != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection("posts")
          .where("userId", isEqualTo: uid)
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
