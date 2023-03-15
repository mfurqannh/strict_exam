import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strict_exam/features/authentication/controllers/getuser_controller.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';
import 'package:strict_exam/routing/routes.dart';

class AuthenticationRepository extends GetxController {
  GetUserController getUserController = Get.put(GetUserController());
  UserRepository userRepo = Get.put(UserRepository());

  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  bool? enter = false;

  @override
  void onReady() async {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    final pref = await SharedPreferences.getInstance();
    enter = pref.getBool('enter');
    setInitialScreen(enter!);
  }

  Future<SharedPreferences> createPreferences() async {
    final pref = await SharedPreferences.getInstance();
    return pref;
  }

  setInitialScreen(bool enter) {
    enter
        ? Get.offAllNamed(AppRoutes.signin)
        : Get.offAllNamed(AppRoutes.splashScreen);
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser.value != null) {
        await getUserController.getUserData(email);
        Get.offAllNamed(AppRoutes.homeSiswa, arguments: getUserController.user);
        setPreferences();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Peringatan", "Pastikan data yang dimasukan benar",
          snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    if (email == 'admin@admin.com') {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (firebaseUser.value != null) {
          Get.offAllNamed(AppRoutes.homeGuru);
          setPreferences();
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Peringatan", "Email atau password salah",
            snackPosition: SnackPosition.BOTTOM);
        print(e);
      }
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (firebaseUser.value != null) {
          await getUserController.getUserData(email);
          Get.offAllNamed(AppRoutes.homeSiswa,
              arguments: getUserController.user);
          setPreferences();
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Peringatan", "Email atau password salah",
            snackPosition: SnackPosition.BOTTOM);
        print(e);
      }
    }
  }

  Future<void> logout() async {
    _auth.signOut();
    // Get.delete(force: true);
    Get.offAllNamed(AppRoutes.signin);
  }

  setPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enter', true);
  }
}
