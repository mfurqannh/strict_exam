import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';

import 'package:strict_exam/routing/routes.dart';
import '../../controllers/buat_soal_controller.dart';

// ignore: must_be_immutable
class BuatSoalUjian extends StatelessWidget {
  BuatSoalUjian({super.key});
  BuatSoalUjianController soalController = Get.find();

  // final ujianModel = Get.arguments;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        actions: [
          Obx(() => Center(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "No. ${soalController.noSoal.toString()}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    )),
              ))
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // const Spacer(),
                    TextFormField(
                      controller: soalController.pertanyaan,
                      maxLines: 3,
                      validator: (value) {
                        return value!.isEmpty ? "Masukkan Pertanyaan" : null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Pertanyaan",
                        hintText: "Pertanyaan",
                      ),
                      onChanged: (value) {
                        soalController.setSoal(value, "pertanyaan");
                      },
                    ),
                    TextFormField(
                      controller: soalController.pilihan1,
                      validator: (value) {
                        return value!.isEmpty ? "Masukkan Pilihan 1" : null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Pilihan 1",
                        hintText: "Pilihan 1",
                      ),
                      onChanged: (value) {
                        soalController.setSoal(value, "pilihan1");
                      },
                    ),
                    TextFormField(
                      controller: soalController.pilihan2,
                      validator: (value) {
                        return value!.isEmpty ? "Masukkan Pilihan 2" : null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Pilihan 2",
                        hintText: "Pilihan 2",
                      ),
                      onChanged: (value) {
                        soalController.setSoal(value, "pilihan2");
                      },
                    ),
                    TextFormField(
                      controller: soalController.pilihan3,
                      validator: (value) {
                        return value!.isEmpty ? "Masukkan Pilihan 3" : null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Pilihan 3",
                        hintText: "Pilihan 3",
                      ),
                      onChanged: (value) {
                        soalController.setSoal(value, "pilihan3");
                      },
                    ),
                    TextFormField(
                      controller: soalController.pilihan4,
                      validator: (value) {
                        return value!.isEmpty ? "Masukkan Pilihan 4" : null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Pilihan 4",
                        hintText: "Pilihan 4",
                      ),
                      onChanged: (value) {
                        soalController.setSoal(value, "pilihan4");
                      },
                    ),
                    TextFormField(
                      controller: soalController.pilihan5,
                      validator: (value) {
                        return value!.isEmpty ? "Masukkan Pilihan 5" : null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Pilihan 5",
                        hintText: "Pilihan 5",
                      ),
                      onChanged: (value) {
                        soalController.setSoal(value, "pilihan5");
                      },
                    ),
                    TextFormField(
                      controller: soalController.jawaban,
                      validator: (value) {
                        return value!.isEmpty ? "Masukkan Kunci Jawaban" : null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Kunci Jawaban",
                        hintText: "Kunci Jawaban",
                      ),
                      onChanged: (value) {
                        soalController.setSoal(value, "jawaban");
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: soalController.isPertama,
                          child: ElevatedButton(
                              onPressed: () {
                                soalController.pertanyaanSebelumnya();
                              },
                              child: const Text("Prev")),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              soalController.isTerakhir
                                  ? soalController.pertanyaanSelanjutnya()
                                  : Get.defaultDialog(
                                      title: "Pemberitahuan",
                                      middleText:
                                          "Ujian telah berhasil ditambahkan",
                                      textConfirm: "OK",
                                      onConfirm: () {
                                        soalController.simpanSoal();
                                        Get.offNamed(AppRoutes.homeGuru);
                                      },
                                    );
                            },
                            child: Text(
                                soalController.isTerakhir ? "Next" : "Simpan")),
                      ],
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
      ),
    );
  }
}
