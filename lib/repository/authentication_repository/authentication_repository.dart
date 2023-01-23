import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/controllers/getuser_controller.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';
import 'package:strict_exam/routing/routes.dart';

class AuthenticationRepository extends GetxController {
  // static AuthenticationRepository get instance => Get.find();
  // AuthenticationRepository instance = Get.put(AuthenticationRepository());
  GetUserController getUserController = Get.put(GetUserController());
  UserRepository userRepo = Get.put(UserRepository());

  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAllNamed(AppRoutes.splashScreen)
        : Get.offAllNamed(AppRoutes.signin);
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser.value != null) {
        await getUserController.getUserData(email);
        Get.offAllNamed(AppRoutes.homeSiswa, arguments: getUserController.user);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Peringatan", "Pastikan data yang dimasukan benar",
          snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    if (email == 'admin' && password == 'admin') {
      Get.offAllNamed(AppRoutes.homeGuru);
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (firebaseUser.value != null) {
          await getUserController.getUserData(email);
          Get.offAllNamed(AppRoutes.homeSiswa,
              arguments: getUserController.user);
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Peringatan", "Email atau password salah",
            snackPosition: SnackPosition.BOTTOM);
        print(e);
      }
    }
  }

  Future<void> logout() async => _auth.signOut();
}
