import 'package:flutter/material.dart';
import 'package:strict_exam/views/masuk.dart';
import 'package:strict_exam/widgets/widgets.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                  controller: namaController,
                  validator: (value) {
                    // print("validate");
                    return value!.isEmpty ? "Masukkan Nama" : null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Nama", hintText: "Nama"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: emailController,
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
                  controller: passwordController,
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
                  onPressed: () {},
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SignIn())));
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
