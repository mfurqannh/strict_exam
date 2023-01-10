import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/screens/masuk.dart';
import 'package:strict_exam/features/authentication/screens/splash.dart';
import 'package:strict_exam/features/manage_exams/screens/home.dart';
import 'package:strict_exam/features/run_exams/screens/home.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

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
        ? Get.offAll(() => const Splash())
        : Get.offAll(() => SignIn());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String, password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeSiswa())
          : Get.offAll(() => const Splash());
    } on FirebaseAuthException catch (e) {}
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    if (email == 'admin@admin.com' && password == 'admin123') {
      Get.offAll(() => const HomeGuru());
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        firebaseUser.value != null ? Get.offAll(() => const HomeSiswa()) : null;
      } on FirebaseAuthException catch (e) {}
    }
  }

  Future<void> logout() async => _auth.signOut();
}