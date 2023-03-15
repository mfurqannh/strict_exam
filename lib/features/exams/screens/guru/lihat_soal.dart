import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/lihat_soal_controller.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:strict_exam/routing/routes.dart';

import '../../../../common_widgets/widgets.dart';
import '../../widgets/soal/pilihan_card.dart';

// ignore: must_be_immutable
class LihatSoal extends StatelessWidget {
  LihatSoal({super.key});

  LihatSoalController controller = Get.find();
  final ujianModel = Get.arguments as UjianModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          centerTitle: true,
          actions: [
            TextButton.icon(
                onPressed: () {
                  final idSoal = controller.soalSekarang.value?.id ?? "";
                  final idUjian = ujianModel.id;
                  final noSoal = controller.noSoal.value;
                  final pertanyaan = Pertanyaan(
                      pertanyaan:
                          controller.soalSekarang.value?.pertanyaan ?? "",
                      jawaban: controller.soalSekarang.value?.jawaban ?? "",
                      pilihan1: controller.soalSekarang.value?.pilihan1 ?? "",
                      pilihan2: controller.soalSekarang.value?.pilihan2 ?? "",
                      pilihan3: controller.soalSekarang.value?.pilihan3 ?? "",
                      pilihan4: controller.soalSekarang.value?.pilihan4 ?? "",
                      pilihan5: controller.soalSekarang.value?.pilihan5 ?? "");
                  Get.toNamed(AppRoutes.editSoal,
                      arguments: [idUjian, idSoal, noSoal, pertanyaan]);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Obx(() => Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            height: 25,
                            width: 85,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Text(
                              "No. Soal ${controller.noSoal}",
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                            controller.soalSekarang.value?.pertanyaan ?? "")),
                    Column(
                      children: [
                        PilihanCard(
                          pilihan:
                              controller.soalSekarang.value?.pilihan1 ?? "",
                          onTap: () {},
                        ),
                        PilihanCard(
                          pilihan:
                              controller.soalSekarang.value?.pilihan2 ?? "",
                          onTap: () {},
                        ),
                        PilihanCard(
                          pilihan:
                              controller.soalSekarang.value?.pilihan3 ?? "",
                          onTap: () {},
                        ),
                        PilihanCard(
                          pilihan:
                              controller.soalSekarang.value?.pilihan4 ?? "",
                          onTap: () {},
                        ),
                        PilihanCard(
                          pilihan:
                              controller.soalSekarang.value?.pilihan5 ?? "",
                          onTap: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: controller.isPertama,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.pertanyaanSebelumnya();
                              },
                              child: const Text("Prev")),
                        ),
                        Visibility(
                          visible: controller.isTerakhir,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.pertanyaanSelanjutnya();
                              },
                              child: const Text("Next")),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
