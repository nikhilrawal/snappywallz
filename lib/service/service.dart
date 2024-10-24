import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addWallpaper(Map<String, dynamic> map, String id, String name) {
    return FirebaseFirestore.instance.collection(name).doc(id).set(map);
  }

  Future<Stream<QuerySnapshot>> getCategory(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }
}
