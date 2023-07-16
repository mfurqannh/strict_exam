import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/edit_soal_controller.dart';

class EditSoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditSoalController());
  }
}
