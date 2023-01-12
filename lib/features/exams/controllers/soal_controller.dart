import 'package:get/get.dart';
import 'package:strict_exam/repository/soal_repository/soal_repository.dart';

import '../models/soal_model.dart';

class SoalController extends GetxController {
  // static SoalController get instance => Get.find();

  final _soalRepo = Get.put(SoalRepository());
  var idUjian;

  @override
  void onReady() {
    idUjian = Get.arguments;
    print(idUjian);
    super.onReady();
  }

  Future<List<SoalModel>> getsSoal() async {
    return await _soalRepo.getSoalUjian(idUjian);
  }
}
