import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:strict_exam/repository/ujian_repository/ujian_repository.dart';

class ListUjianController extends GetxController {
  final _ujianRepo = Get.put(UjianRepository());
  final ujianData = <UjianModel>[].obs;
  // final isEmpty = true.obs;

  @override
  void onReady() {
    getAllUjian();
    super.onReady();
  }

  toDate(DateTime time) {
    final date = DateFormat('dd-MM-yyyy HH:mm').format(time);
    return date;
  }

  Future<void> getAllUjian() async {
    final getUjian = await _ujianRepo.getUjian();
    ujianData.assignAll(getUjian);
  }

  Future<bool> cekSiswa(UjianModel ujianModel, String? idUser) async {
    return await _ujianRepo.cekSiswa(ujianModel, idUser);
  }
}
