import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/screens/daftar.dart';
import 'package:strict_exam/features/authentication/screens/masuk.dart';
import 'package:strict_exam/features/authentication/screens/permission.dart';
import 'package:strict_exam/features/authentication/screens/splash.dart';
import 'package:strict_exam/features/exams/screens/home_guru.dart';
import 'package:strict_exam/routing/bindings/Home_guru_binding.dart';
import 'package:strict_exam/routing/bindings/soal_binding.dart';
import 'package:strict_exam/routing/bindings/home_siswa_binding.dart';
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
    GetPage(
      name: AppRoutes.homeSiswa,
      page: () => HomeSiswa(),
      binding: HomeSiswaBinding(),
    ),
    GetPage(
        name: AppRoutes.homeGuru,
        page: () => HomeGuru(),
        binding: HomeBindingGuru()),
    GetPage(
      name: AppRoutes.ujian,
      page: () => Ujian(),
      binding: SoalBinding(),
    ),
  ];
}
