import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/repository/ujian_repository/ujian_repository.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';

import '../models/ujian_model.dart';

class HasilUjianGuruController extends GetxController {
  final userRepo = Get.put(UserRepository());
  final ujianRepo = Get.put(UjianRepository());

  Future<Hasil> getHasil(String? idUjian, String? idUser) async {
    final hasil = await userRepo.getUserHasil(idUjian, idUser);
    return hasil;
  }

  Future<Map<UserModel, Hasil>> getSiswa(UjianModel ujianModel) async {
    final list = await ujianRepo.listSiswa(ujianModel);
    final siswa = <UserModel, Hasil>{};

    for (Siswa element in list) {
      final user = await userRepo.getUserbyID(element.idSiswa);
      final hasil = await getHasil(ujianModel.id, element.idSiswa);
      siswa[user] = hasil;
    }
    return siswa;
  }
}
