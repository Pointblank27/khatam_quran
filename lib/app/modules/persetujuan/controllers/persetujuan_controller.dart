import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class PersetujuanController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>?> getDataDitolak() async {
    try {
      String? uid = auth.currentUser?.uid;
      if (uid != null) {
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
            .collection("posts")
            .where("status", isEqualTo: "reject")
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.map((doc) => doc.data()).toList();
        } else {
          print("No rejected posts found.");
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getDataDiterima() async {
    try {
      String? uid = auth.currentUser?.uid;
      if (uid != null) {
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
            .collection("posts")
            .where("status", isEqualTo: "accept")
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.map((doc) => doc.data()).toList();
        } else {
          print("No accepted posts found.");
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
