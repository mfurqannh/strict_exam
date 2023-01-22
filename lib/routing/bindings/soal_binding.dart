import 'package:get/get.dart';

import '../../features/exams/controllers/soal_controller.dart';

class SoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SoalController());
  }
}
