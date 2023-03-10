import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/screens/daftar.dart';
import 'package:strict_exam/features/authentication/screens/masuk.dart';
import 'package:strict_exam/features/authentication/screens/permission.dart';
import 'package:strict_exam/features/authentication/screens/splash.dart';
import 'package:strict_exam/features/exams/screens/guru/detail_hasil_ujian.dart';
import 'package:strict_exam/features/exams/screens/guru/hasil_ujian_guru.dart';
import 'package:strict_exam/features/exams/screens/guru/home_guru.dart';
import 'package:strict_exam/features/exams/screens/siswa/hasil_ujian_siswa.dart';
import 'package:strict_exam/routing/bindings/Home_guru_binding.dart';
import 'package:strict_exam/routing/bindings/detail_hasil_ujian_guru_binding.dart';
import 'package:strict_exam/routing/bindings/hasil_ujian_guru.dart';
import 'package:strict_exam/routing/bindings/hasil_ujian_siswa.dart';
import 'package:strict_exam/routing/bindings/soal_binding.dart';
import 'package:strict_exam/routing/bindings/home_siswa_binding.dart';
import 'package:strict_exam/routing/routes.dart';
import '../features/exams/screens/siswa/home_siswa.dart';
import '../features/exams/screens/siswa/ujian.dart';

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
    GetPage(
      name: AppRoutes.hasilUjianSiswa,
      page: () => HasilUjianSiswa(),
      binding: HasilUjianSiswaBinding(),
    ),
    GetPage(
      name: AppRoutes.hasilUjianGuru,
      page: () => HasilUjianGuru(),
      binding: HasilUjianGuruBinding(),
    ),
    GetPage(
      name: AppRoutes.detailHasilUjianGuru,
      page: () => DetailHasilUjianGuru(),
      binding: DetailHasilUjianGuruBinding(),
    ),
  ];
}
