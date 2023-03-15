import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/user_controller.dart';
import '../../features/exams/controllers/list_ujian_controller.dart';

class HomeSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListUjianController(), permanent: true);
    Get.put(UserController(), permanent: true);
  }
}
