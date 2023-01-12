import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/screens/daftar.dart';
import 'package:strict_exam/features/authentication/screens/masuk.dart';
import 'package:strict_exam/features/authentication/screens/permission.dart';
import 'package:strict_exam/features/authentication/screens/splash.dart';
import 'package:strict_exam/features/exams/controllers/soal_controller.dart';
import 'package:strict_exam/features/exams/screens/home_guru.dart';
import 'package:strict_exam/routing/routes.dart';

import '../features/exams/screens/home_siswa.dart';
import '../features/exams/screens/ujian.dart';

class AppNavigation {
  static final pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => const Splash()),
    GetPage(
        name: AppRoutes.permissionScreen, page: () => const PermissionScreen()),
    GetPage(name: AppRoutes.signin, page: () => SignIn()),
    GetPage(name: AppRoutes.signup, page: () => SignUp()),
    GetPage(name: AppRoutes.homeSiswa, page: () => HomeSiswa()),
    GetPage(name: AppRoutes.homeGuru, page: () => const HomeGuru()),
    GetPage(
        name: AppRoutes.ujian,
        page: () => const Ujian(),
        binding: BindingsBuilder(() {
          Get.put(SoalController());
        })),
  ];
}
