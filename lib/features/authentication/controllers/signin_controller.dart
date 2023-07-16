import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:strict_exam/repository/authentication_repository/authentication_repository.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();
  AuthenticationRepository authRepo = Get.put(AuthenticationRepository());

  //textfield controller to get data from textfields
  final email = TextEditingController();
  final password = TextEditingController();

  //dropdown
  final kelas = "XI RPL A".obs;

  void signInUser(String email, String password) {
    authRepo.loginWithEmailAndPassword(email, password);
  }
}
