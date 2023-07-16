import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/ujian_controller.dart';
import 'package:strict_exam/repository/authentication_repository/authentication_repository.dart';
import '../../features/exams/controllers/list_ujian_controller.dart';

class HomeBindingGuru extends Bindings {
  @override
  void dependencies() {
    Get.put(ListUjianController(), permanent: true);
    Get.put(AuthenticationRepository());
  }
}
