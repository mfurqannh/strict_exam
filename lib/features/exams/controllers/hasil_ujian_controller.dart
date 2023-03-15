import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';

class HasilUjianSiswaController extends GetxController {
  final userRepo = Get.put(UserRepository());
  var hasil = Hasil().obs;

  Future<Hasil> getHasil(String? idUjian, String? idUser) async {
    final hasil = await userRepo.getUserHasil(idUjian, idUser);
    return hasil;
  }

  toDate(DateTime time) {
    final date = DateFormat('dd-MM-yyyy HH:mm').format(time);
    return date;
  }
}
