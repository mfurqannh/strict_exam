import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../features/exams/models/ujian_model.dart';

class UjianRepository extends GetxController {
  static UjianRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUjian(UjianModel ujian) async {
    await _db.collection("Ujian").add(ujian.toJson());
  }

  Future<UjianModel> getSoalUjian(String idujian) async {
    final snapshot = await _db
        .collection("Ujian")
        .doc(idujian)
        .collection("Pertanyaan")
        .get();
    final userData =
        snapshot.docs.map((e) => UjianModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UjianModel>> getUjian() async {
    final snapshot = await _db.collection("Ujian").get();
    final ujianData =
        snapshot.docs.map((e) => UjianModel.fromSnapshot(e)).toList();
    return ujianData;
  }
}
