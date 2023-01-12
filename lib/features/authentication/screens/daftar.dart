import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/controllers/signup_controller.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/routing/routes.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();
  static const List<String> list = <String>[
    'XI RPL A',
    'XI RPL B',
    'XI RPL C',
    'XI RPL D'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: appBar(context),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: controller.nama,
                  validator: (value) {
                    // print("validate");
                    return value!.isEmpty ? "Masukkan Nama" : null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Nama", hintText: "Nama"),
                ),
              ),
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.kelas.value,
                    hint: const Text("Kelas"),
                    isExpanded: true,
                    onChanged: (String? value) {
                      controller.setKelas(value!);
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
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
                    "Daftar",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final user = UserModel(
                          nama: controller.nama.text,
                          kelas: controller.kelas.value,
                          email: controller.email.text);

                      SignUpController.instance.createUser(user);
                      SignUpController.instance.registerUser(
                          controller.email.text, controller.password.text);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sudah punya akun? ",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    GestureDetector(
                      child: const Text(
                        "Masuk",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        Get.offNamed(AppRoutes.signin);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
