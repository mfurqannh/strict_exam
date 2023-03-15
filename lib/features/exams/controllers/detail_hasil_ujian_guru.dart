import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';

class DetailHasilUjianGuruController extends GetxController {
  UserRepository userRepo = Get.put(UserRepository());
  // List<Aktivitas> aktivitas = <Aktivitas>[];

  @override
  void onReady() {
    final args = Get.arguments;
    final ujianModel = args[0] as UjianModel;
    final user = args[1] as UserModel;
    // final idUser = user.id;
    getAktivitas(user.id, ujianModel.id);
    super.onReady();
  }

  Future<List<Aktivitas>> getAktivitas(String? idUser, String? idUjian) async {
    final aktivitas = await userRepo.getAktivitas(idUser, idUjian);
    return aktivitas;
  }

  toDate(Timestamp time) {
    final date = DateFormat('HH:mm:ss').format(time.toDate());
    return date;
  }
}
