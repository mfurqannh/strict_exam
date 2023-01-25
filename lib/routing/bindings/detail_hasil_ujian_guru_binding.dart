import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/detail_hasil_ujian_guru.dart';

class DetailHasilUjianGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailHasilUjianGuruController());
  }
}
