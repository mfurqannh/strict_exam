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
    for (Pertanyaan pertanyaan in ujianModel.pertanyaan!) {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection("Ujian")
          .doc(ujianModel.id)
          .collection("Pertanyaan")
          .doc(pertanyaan.id)
          .collection("Pilihan")
          .get();
      final pilihan =
          snapshot.docs.map((e) => Pilihan.fromSnapshot(e)).toList();
      pertanyaan.pilihan = pilihan;
      if (pertanyaan.pilihan != null && pertanyaan.pilihan.isNotEmpty) {
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
    // for (var element in ujianData) {
    //   final QuerySnapshot<Map<String, dynamic>> snap = await _db
    //       .collection("Ujian")
    //       .doc(element.id)
    //       .collection("Siswa")
    //       .get();
    // }
    return ujianData;
  }

  addSiswa(UjianModel ujianModel, Siswa siswa) async {
    await _db
        .collection("Ujian")
        .doc(ujianModel.id)
        .collection("Siswa")
        .add(siswa.toJson());
  }

  Future<bool> cekSiswa(UjianModel ujianModel, String? idUser) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Ujian")
        .doc(ujianModel.id)
        .collection("Siswa")
        .get();
    final siswaData = snapshot.docs.map((e) => Siswa.fromSnapshot(e)).toList();
    var isEmpty = true;
    for (var element in siswaData) {
      if (element.idSiswa == idUser) {
        isEmpty = false;
      }
    }
    return isEmpty;
  }

  Future<List<Siswa>> listSiswa(UjianModel ujianModel) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Ujian")
        .doc(ujianModel.id)
        .collection("Siswa")
        .get();
    final siswaData = snapshot.docs.map((e) => Siswa.fromSnapshot(e)).toList();
    return siswaData;
  }
}
