import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/ujian_repository/ujian_repository.dart';
import '../models/ujian_model.dart';

class EditSoalController extends GetxController {
  final ujianRepo = Get.put(UjianRepository());

  final pertanyaan = TextEditingController();
  final pilihan1 = TextEditingController();
  final pilihan2 = TextEditingController();
  final pilihan3 = TextEditingController();
  final pilihan4 = TextEditingController();
  final pilihan5 = TextEditingController();
  final jawaban = TextEditingController();

  var pertanyaanM = Pertanyaan(
      pertanyaan: "",
      jawaban: "",
      pilihan1: "",
      pilihan2: "",
      pilihan3: "",
      pilihan4: "",
      pilihan5: "");

  var idUjian = "";
  var idSoal = "";
  // var noSoal = 0.obs;

  @override
  void onReady() {
    final args = Get.arguments;
    idUjian = args[0]!;
    idSoal = args[1];
    // noSoal = args[2];
    pertanyaanM = args[3];
    setTextEditor();
    super.onReady();
  }

  setTextEditor() {
    pertanyaan.text = pertanyaanM.pertanyaan;
    pilihan1.text = pertanyaanM.pilihan1;
    pilihan2.text = pertanyaanM.pilihan2;
    pilihan3.text = pertanyaanM.pilihan3;
    pilihan4.text = pertanyaanM.pilihan4;
    pilihan5.text = pertanyaanM.pilihan5;
    jawaban.text = pertanyaanM.jawaban;
  }

  simpanSoal() {
    ujianRepo.editPertanyaan(idUjian, idSoal, pertanyaanM);
  }
}
