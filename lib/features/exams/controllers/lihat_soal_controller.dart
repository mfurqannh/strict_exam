import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../repository/ujian_repository/ujian_repository.dart';
import '../models/ujian_model.dart';

class LihatSoalController extends GetxController {
  final _ujianRepo = Get.put(UjianRepository());

  var ujianModel = UjianModel(
      id: "", judul: "", deskripsi: "", durasi: 0, waktu: Timestamp.now());
  final allSoal = <Pertanyaan>[];
  Rxn<Pertanyaan> soalSekarang = Rxn<Pertanyaan>();
  final index = 0.obs;
  final noSoal = 1.obs;
  bool get isPertama => index.value > 0;
  bool get isTerakhir => index.value < allSoal.length - 1;

  @override
  void onReady() {
    final arg = Get.arguments;
    ujianModel = arg as UjianModel;
    loadData(ujianModel);
    super.onReady();
  }

  Future<void> loadData(UjianModel ujianModel) async {
    final getSoal = await _ujianRepo.getSoal(ujianModel);
    allSoal.assignAll(getSoal!);
    pertanyaanSekarang();
  }

  pertanyaanSekarang() {
    if (allSoal != null && allSoal.isNotEmpty) {
      soalSekarang.value = allSoal[index.value];
    }
  }

  pertanyaanSelanjutnya() {
    if (index.value >= allSoal.length - 1) return;
    index.value++;
    noSoal.value++;
    soalSekarang.value = allSoal[index.value];
  }

  pertanyaanSebelumnya() {
    if (index.value <= 0) return;
    index.value--;
    noSoal.value--;
    soalSekarang.value = allSoal[index.value];
  }
}
