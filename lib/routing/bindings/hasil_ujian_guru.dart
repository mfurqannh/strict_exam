import 'package:get/get.dart';
import '../../features/exams/controllers/hasil_ujian_guru_controller.dart';

class HasilUjianGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HasilUjianGuruController());
  }
}
