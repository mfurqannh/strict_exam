import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/repository/authentication_repository/authentication_repository.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //textfield controller to get data from textfields
  final nama = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  //dropdown
  final kelas = "XI RPL A".obs;

  final userRepoitory = Get.put(UserRepository());

  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, String, password);
  }

  void createUser(UserModel user) {
    userRepoitory.createUser(user);
  }

  void setKelas(String value) {
    kelas.value = value;
  }
}
