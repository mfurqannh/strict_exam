import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/repository/ujian_repository/ujian_repository.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';

class HasilUjianController extends GetxController {
  final userRepo = Get.put(UserRepository());
  final ujianRepo = Get.put(UjianRepository());
  var hasil = Hasil().obs;

  Future<Hasil> getHasil(String? idUjian, String? idUser) async {
    final hasil = await userRepo.getUserHasil(idUjian, idUser);
    return hasil;
  }
}
