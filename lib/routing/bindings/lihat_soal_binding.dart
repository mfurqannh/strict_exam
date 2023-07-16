import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/lihat_soal_controller.dart';

class LihatSoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LihatSoalController());
  }
}
