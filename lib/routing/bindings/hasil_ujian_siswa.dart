import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/hasil_ujian_controller.dart';

class HasilUjianSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HasilUjianController());
  }
}
