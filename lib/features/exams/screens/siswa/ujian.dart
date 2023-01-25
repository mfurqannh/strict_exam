import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/exams/controllers/soal_controller.dart';
import 'package:strict_exam/routing/routes.dart';
import '../../widgets/soal/pilihan_card.dart';

// ignore: must_be_immutable
class Ujian extends StatelessWidget {
  Ujian({super.key});

  SoalController controller = Get.find();

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: appBar(context),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              TextButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Peringatan",
                      middleText: "Apakah anda yakin akan mengakhiri ujian?",
                      cancel: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text("Tidak"),
                      ),
                      confirm: ElevatedButton(
                        onPressed: () {
                          controller.getDND(FlutterDnd.INTERRUPTION_FILTER_ALL);
                          controller.simpanJawaban();
                          Get.delete<SoalController>();
                          Get.offNamed(AppRoutes.homeSiswa);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text("Ya"),
                      ),
                    );
                  },
                  child: const Text(
                    "Selesai",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          body: Obx(() => Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                              "${controller.noSoal}. ${controller.soalSekarang.value?.pertanyaan ?? ""}")),
                      GetBuilder<SoalController>(
                          id: "list_pilihan",
                          builder: (context) {
                            return Column(
                              children: [
                                PilihanCard(
                                  pilihan:
                                      controller.soalSekarang.value?.pilihan1 ??
                                          "",
                                  onTap: () {
                                    controller.setJawaban(
                                        controller.soalSekarang.value?.pilihan1,
                                        controller.soalSekarang.value?.id);
                                  },
                                  isSelected:
                                      controller.soalSekarang.value?.pilihan1 ==
                                          controller
                                              .soalSekarang.value?.jawabanSiswa,
                                ),
                                PilihanCard(
                                  pilihan:
                                      controller.soalSekarang.value?.pilihan2 ??
                                          "",
                                  onTap: () {
                                    controller.setJawaban(
                                        controller.soalSekarang.value?.pilihan2,
                                        controller.soalSekarang.value?.id);
                                  },
                                  isSelected:
                                      controller.soalSekarang.value?.pilihan2 ==
                                          controller
                                              .soalSekarang.value?.jawabanSiswa,
                                ),
                                PilihanCard(
                                  pilihan:
                                      controller.soalSekarang.value?.pilihan3 ??
                                          "",
                                  onTap: () {
                                    controller.setJawaban(
                                        controller.soalSekarang.value?.pilihan3,
                                        controller.soalSekarang.value?.id);
                                  },
                                  isSelected:
                                      controller.soalSekarang.value?.pilihan3 ==
                                          controller
                                              .soalSekarang.value?.jawabanSiswa,
                                ),
                                PilihanCard(
                                  pilihan:
                                      controller.soalSekarang.value?.pilihan4 ??
                                          "",
                                  onTap: () {
                                    controller.setJawaban(
                                        controller.soalSekarang.value?.pilihan4,
                                        controller.soalSekarang.value?.id);
                                  },
                                  isSelected:
                                      controller.soalSekarang.value?.pilihan4 ==
                                          controller
                                              .soalSekarang.value?.jawabanSiswa,
                                ),
                                PilihanCard(
                                  pilihan:
                                      controller.soalSekarang.value?.pilihan5 ??
                                          "",
                                  onTap: () {
                                    controller.setJawaban(
                                        controller.soalSekarang.value?.pilihan5,
                                        controller.soalSekarang.value?.id);
                                  },
                                  isSelected:
                                      controller.soalSekarang.value?.pilihan5 ==
                                          controller
                                              .soalSekarang.value?.jawabanSiswa,
                                ),
                              ],
                            );
                          }),
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
              ))),
    );
  }
}
