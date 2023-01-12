import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:strict_exam/repository/ujian_repository/ujian_repository.dart';

class UjianController extends GetxController {
  // static UjianController get instance => Get.find();
  final _ujianRepo = Get.put(UjianRepository());

  Future<List<UjianModel>> getAllUjian() async {
    return await _ujianRepo.getUjian();
  }

  toDate(Timestamp time) {
    final date = DateFormat('dd-MM-yyyy HH:mm').format(time.toDate());
    return date.toString();
  }
}
