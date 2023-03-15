import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/edit_soal_controller.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';

import '../../../../common_widgets/widgets.dart';

class EditSoal extends StatelessWidget {
  EditSoal({super.key});
  EditSoalController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final noSoal = args[2];
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        actions: [
          Center(
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "No. Soal $noSoal",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // const Spacer(),
                  TextFormField(
                    controller: controller.pertanyaan,
                    maxLines: 3,
                    validator: (value) {
                      return value!.isEmpty ? "Masukkan Pertanyaan" : null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Pertanyaan",
                      hintText: "Pertanyaan",
                    ),
                  ),
                  TextFormField(
                    controller: controller.pilihan1,
                    validator: (value) {
                      return value!.isEmpty ? "Masukkan Pilihan 1" : null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Pilihan 1",
                      hintText: "Pilihan 1",
                    ),
                  ),
                  TextFormField(
                    controller: controller.pilihan2,
                    validator: (value) {
                      return value!.isEmpty ? "Masukkan Pilihan 2" : null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Pilihan 2",
                      hintText: "Pilihan 2",
                    ),
                  ),
                  TextFormField(
                    controller: controller.pilihan3,
                    validator: (value) {
                      return value!.isEmpty ? "Masukkan Pilihan 3" : null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Pilihan 3",
                      hintText: "Pilihan 3",
                    ),
                  ),
                  TextFormField(
                    controller: controller.pilihan4,
                    validator: (value) {
                      return value!.isEmpty ? "Masukkan Pilihan 4" : null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Pilihan 4",
                      hintText: "Pilihan 4",
                    ),
                  ),
                  TextFormField(
                    controller: controller.pilihan5,
                    validator: (value) {
                      return value!.isEmpty ? "Masukkan Pilihan 5" : null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Pilihan 5",
                      hintText: "Pilihan 5",
                    ),
                  ),
                  TextFormField(
                    controller: controller.jawaban,
                    validator: (value) {
                      return value!.isEmpty ? "Masukkan Kunci Jawaban" : null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Kunci Jawaban",
                      hintText: "Kunci Jawaban",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          final pertanyaan = Pertanyaan(
                              pertanyaan: controller.pertanyaan.text,
                              jawaban: controller.jawaban.text,
                              pilihan1: controller.pilihan1.text,
                              pilihan2: controller.pilihan2.text,
                              pilihan3: controller.pilihan3.text,
                              pilihan4: controller.pilihan4.text,
                              pilihan5: controller.pilihan5.text);
                          controller.pertanyaanM = pertanyaan;
                          controller.simpanSoal();
                          Get.back();
                        },
                        child: const Text("Simpan Pertanyaan")),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
