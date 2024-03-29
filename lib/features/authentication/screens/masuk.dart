// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/controllers/signin_controller.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/routing/routes.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final controller = Get.put(SignInController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: appBar(context),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Info",
                  middleText:
                      "Aplikasi ini dibuat oleh\nMuhammad Furqan Nur Hakim\nMahasiswa Pendidikan Ilmu Komputer\nUniversitas Pendidikan Indonesia",
                );
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 250,
                  width: 250,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    controller: controller.email,
                    validator: (value) {
                      // print("validate");
                      return value!.isEmpty ? "Masukkan Email" : null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Email", hintText: "Email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    controller: controller.password,
                    validator: (value) {
                      return value!.isEmpty ? "Masukkan Password" : null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Password", hintText: "Password"),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text(
                      "Masuk",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      controller.signInUser(
                          controller.email.text, controller.password.text);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum punya akun? ",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      GestureDetector(
                        child: const Text(
                          "Daftar",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        onTap: () {
                          Get.offNamed(AppRoutes.signup);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
