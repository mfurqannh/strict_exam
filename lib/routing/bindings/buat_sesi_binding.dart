import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/buat_sesi_controller.dart';

class BuatSesiUjianBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BuatSesiUjianController());
  }
}
