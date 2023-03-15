import 'package:get/get.dart';

import '../../features/exams/controllers/ujian_controller.dart';

class UjianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UjianController());
  }
}
