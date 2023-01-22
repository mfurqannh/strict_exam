import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/user_controller.dart';

import '../../features/exams/controllers/ujian_controller.dart';

class HomeSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UjianController());
    Get.put(UserController());
  }
}
