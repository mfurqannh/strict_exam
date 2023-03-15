import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';

class GetUserController extends GetxController {
  // final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  UserModel user = UserModel(nama: "nama", kelas: "kelas", email: "");
  int i = 0;

  Future<void> getUserData(email) async {
    user = await _userRepo.getUserData(email);
    i++;
  }
}
