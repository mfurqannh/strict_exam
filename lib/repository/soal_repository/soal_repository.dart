import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/exams/models/soal_model.dart';

class SoalRepository extends GetxController {
  static SoalRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<SoalModel>> getSoalUjian(String idujian) async {
    final snapshot = await _db
        .collection("Ujian")
        .doc(idujian)
        .collection("Pertanyaan")
        .get();
    final userData =
        snapshot.docs.map((e) => SoalModel.fromSnapshot(e)).toList();

    for (var data in userData) {}

    return userData;
  }

  Future<List<SoalModel>> getUjian() async {
    final snapshot = await _db.collection("Ujian").get();
    final ujianData =
        snapshot.docs.map((e) => SoalModel.fromSnapshot(e)).toList();
    return ujianData;
  }
}
