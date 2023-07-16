import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/exams/controllers/ujian_controller.dart';
import 'package:strict_exam/features/exams/widgets/soal/nosoal.dart';
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
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5),
                              height: 25,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Text(
                                controller.time.value,
                                style: const TextStyle(fontSize: 12),
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
                      //JANGAN LUPA HAPUS
                      // Text("Nilai"),
                      Obx(() =>
                          Text("Nilai: ${controller.z.value.toString()}")),
                      Obx(() => Text(
                          "Total Durasi: ${controller.totDurasi.value.toString()}")),
                      Text("Kunci Jawaban"),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                              controller.soalSekarang.value?.jawaban ?? "")),
                      GetBuilder<UjianController>(
                          id: "list_pilihan",
                          builder: (context) {
                            List<String> listPilihan = [
                              controller.soalSekarang.value?.pilihan1 ?? "",
                              controller.soalSekarang.value?.pilihan2 ?? "",
                              controller.soalSekarang.value?.pilihan3 ?? "",
                              controller.soalSekarang.value?.pilihan4 ?? "",
                              controller.soalSekarang.value?.pilihan5 ?? "",
                            ];
                            // final random = Random();
                            // listPilihan.shuffle(random);
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return PilihanCard(
                                  pilihan: listPilihan[index].toString(),
                                  onTap: () {
                                    controller.setJawaban(
                                        listPilihan[index].toString(),
                                        controller.soalSekarang.value?.id);
                                    if (controller
                                            .soalSekarang.value?.jawabanSiswa ==
                                        controller
                                            .soalSekarang.value?.jawaban) {
                                      controller.x.value++;
                                    }
                                  },
                                  isSelected: listPilihan[index].toString() ==
                                      controller
                                          .soalSekarang.value?.jawabanSiswa,
                                );
                              },
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
                      const SizedBox(
                        height: 50,
                      ),
                      GridView.count(
                          crossAxisCount: 5,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 5,
                          childAspectRatio: 1.8,
                          shrinkWrap: true,
                          children: List.generate(
                              controller.allSoal.length,
                              (index) => NoSoal(
                                    onTap: () {
                                      controller.pertanyaanTertentu(index);
                                    },
                                    nomor: '${index + 1}',
                                    isSelected: controller.index.value == index,
                                  ))),
                      const SizedBox(
                        height: 70,
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
