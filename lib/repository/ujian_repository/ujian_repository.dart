import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../features/exams/models/ujian_model.dart';

class UjianRepository extends GetxController {
  final _db = FirebaseFirestore.instance;

  Future<List<Pertanyaan>?> getSoal(UjianModel ujianModel) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Ujian")
        .doc(ujianModel.id)
        .collection("Pertanyaan")
        .get();
    final soalData =
        snapshot.docs.map((e) => Pertanyaan.fromSnapshot(e)).toList();
    ujianModel.pertanyaan = soalData;
    for (Pertanyaan _pertanyaan in ujianModel.pertanyaan!) {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection("Ujian")
          .doc(ujianModel.id)
          .collection("Pertanyaan")
          .doc(_pertanyaan.id)
          .collection("Pilihan")
          .get();
      final pilihan =
          snapshot.docs.map((e) => Pilihan.fromSnapshot(e)).toList();
      _pertanyaan.pilihan = pilihan;
      if (_pertanyaan.pilihan != null && _pertanyaan.pilihan.isNotEmpty) {
        if (ujianModel.pertanyaan != null &&
            ujianModel.pertanyaan!.isNotEmpty) {
          return ujianModel.pertanyaan;
        }
      }
    }
  }

  createUjian(UjianModel ujian) async {
    await _db.collection("Ujian").add(ujian.toJson());
  }

  Future<List<UjianModel>> getUjian() async {
    final snapshot = await _db.collection("Ujian").get();
    final ujianData =
        snapshot.docs.map((e) => UjianModel.fromSnapshot(e)).toList();
    return ujianData;
  }
}
