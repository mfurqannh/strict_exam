import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/repository/authentication_repository/authentication_repository.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  AuthenticationRepository authRepo = Get.put(AuthenticationRepository());
  final userRepoitory = Get.put(UserRepository());

  //textfield controller to get data from textfields
  final nama = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final kelas = TextEditingController();

  void registerUser(String email, String password) {
    authRepo.createUserWithEmailAndPassword(email, password);
  }

  void createUser(UserModel user) {
    userRepoitory.createUser(user);
  }
}
