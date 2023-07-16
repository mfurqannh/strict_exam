import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:uuid/uuid.dart';
import '../../../repository/ujian_repository/ujian_repository.dart';

class BuatSoalUjianController extends GetxController {
  final ujianRepo = Get.put(UjianRepository());

  final pertanyaan = TextEditingController();
  final pilihan1 = TextEditingController();
  final pilihan2 = TextEditingController();
  final pilihan3 = TextEditingController();
  final pilihan4 = TextEditingController();
  final pilihan5 = TextEditingController();
  final jawaban = TextEditingController();

  late UjianModel ujianModel;
  final allSoal = <Pertanyaan>[];
  final listSoal = <Pertanyaan>[];
  Rxn<Pertanyaan> soalSekarang = Rxn<Pertanyaan>();
  final addPertanyaan = Pertanyaan(
      pertanyaan: "",
      jawaban: "",
      pilihan1: "",
      pilihan2: "",
      pilihan3: "",
      pilihan4: "",
      pilihan5: "");
  final index = 0.obs;
  final noSoal = 1.obs;

  bool get isPertama => index.value > 0;
  bool get isTerakhir => index.value < allSoal.length - 1;

  @override
  void onReady() {
    final args = Get.arguments;
    ujianModel = args[0];
    final jumlahSoal = args[1];
    createPertanyaan(jumlahSoal);
    super.onReady();
  }

  createPertanyaan(int jumlahSoal) {
    for (var i = 0; i < jumlahSoal; i++) {
      allSoal.add(Pertanyaan(
          pertanyaan: "",
          jawaban: "",
          pilihan1: "",
          pilihan2: "",
          pilihan3: "",
          pilihan4: "",
          pilihan5: ""));
    }
  }

  pertanyaanSelanjutnya() {
    final id = const Uuid().v1();
    print(id);
    index.value++;
    noSoal.value++;
    pertanyaan.text = allSoal[index.value].pertanyaan;
    pilihan1.text = allSoal[index.value].pilihan1;
    pilihan2.text = allSoal[index.value].pilihan2;
    pilihan3.text = allSoal[index.value].pilihan3;
    pilihan4.text = allSoal[index.value].pilihan4;
    pilihan5.text = allSoal[index.value].pilihan5;
    jawaban.text = allSoal[index.value].jawaban;
  }

  pertanyaanSebelumnya() {
    index.value--;
    noSoal.value--;
    pertanyaan.text = allSoal[index.value].pertanyaan;
    pilihan1.text = allSoal[index.value].pilihan1;
    pilihan2.text = allSoal[index.value].pilihan2;
    pilihan3.text = allSoal[index.value].pilihan3;
    pilihan4.text = allSoal[index.value].pilihan4;
    pilihan5.text = allSoal[index.value].pilihan5;
    jawaban.text = allSoal[index.value].jawaban;
  }

  setSoal(String value, String input) {
    switch (input) {
      case "pertanyaan":
        allSoal[index.value].pertanyaan = value;
        break;
      case "pilihan1":
        allSoal[index.value].pilihan1 = value;
        break;
      case "pilihan2":
        allSoal[index.value].pilihan2 = value;
        break;
      case "pilihan3":
        allSoal[index.value].pilihan3 = value;
        break;
      case "pilihan4":
        allSoal[index.value].pilihan4 = value;
        break;
      case "pilihan5":
        allSoal[index.value].pilihan5 = value;
        break;
      case "jawaban":
        allSoal[index.value].jawaban = value;
        break;
      default:
    }
  }

  simpanSoal() {
    final idUjian = const Uuid().v1();
    ujianRepo.createUjian(ujianModel, idUjian);

    for (Pertanyaan pertanyaan in allSoal) {
      ujianRepo.addPertanyaan(idUjian, pertanyaan);
    }
  }
}
