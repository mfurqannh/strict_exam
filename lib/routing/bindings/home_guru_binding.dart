import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/ujian_controller.dart';

class HomeBindingGuru extends Bindings {
  @override
  void dependencies() {
    Get.put(UjianController());
  }
}
