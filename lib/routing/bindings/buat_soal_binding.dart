import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/buat_soal_controller.dart';

class BuatSoalUjianBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BuatSoalUjianController());
  }
}
