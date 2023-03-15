import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/exams/controllers/ujian_controller.dart';
import 'package:strict_exam/routing/routes.dart';
import '../../widgets/soal/pilihan_card.dart';

// ignore: must_be_immutable
class Ujian extends StatelessWidget {
  Ujian({super.key});

  UjianController controller = Get.find();

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
                          controller.simpanJawaban();
                          Get.delete<UjianController>();
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
                              padding: EdgeInsets.all(5),
                              height: 25,
                              width: 85,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                "No. Soal ${controller.noSoal}",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              height: 25,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                controller.time.value,
                                style: TextStyle(fontSize: 12),
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
                      GetBuilder<UjianController>(
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
                      SizedBox(
                        height: 70,
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
