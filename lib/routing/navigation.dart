import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/screens/daftar.dart';
import 'package:strict_exam/features/authentication/screens/masuk.dart';
import 'package:strict_exam/features/authentication/screens/permission.dart';
import 'package:strict_exam/features/authentication/screens/splash.dart';
import 'package:strict_exam/features/manage_exams/screens/home.dart';
import 'package:strict_exam/features/run_exams/screens/home.dart';
import 'package:strict_exam/routing/routes.dart';

class AppNavigation {
  static final pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => const Splash()),
    GetPage(
        name: AppRoutes.permissionScreen, page: () => const PermissionScreen()),
    GetPage(name: AppRoutes.signin, page: () => SignIn()),
    GetPage(name: AppRoutes.signup, page: () => SignUp()),
    GetPage(name: AppRoutes.homeSiswa, page: () => const HomeSiswa()),
    GetPage(name: AppRoutes.homeGuru, page: () => const HomeGuru()),
  ];
}
