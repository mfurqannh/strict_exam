import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/repository/authentication_repository/authentication_repository.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';

class UserController extends GetxController {
  // static UserController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  var user = UserModel(nama: "", kelas: "", email: "").obs;
  var hasil = Hasil().obs;

  @override
  void onReady() {
    user.value = Get.arguments;
    super.onReady();
  }

  Future<UserModel> getUserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    return await _userRepo.getUserData(email!);
  }

  Future<void> getHasil(String? idUjian, String? idUser) async {
    hasil.value = await _userRepo.getUserHasil(idUjian, idUser);
  }

  Future<List<UserModel>> getAllUsers() async {
    return await _userRepo.getAllUsers();
  }

  Future<void> signOut() async {
    await _authRepo.logout();
  }
}
