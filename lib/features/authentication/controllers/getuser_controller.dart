import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/repository/authentication_repository/authentication_repository.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';

class GetUserController extends GetxController {
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  UserModel user = UserModel(nama: "", kelas: "", email: "");

  Future<void> getUserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    user = await _userRepo.getUserData(email!);
  }
}
