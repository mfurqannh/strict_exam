import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/exams/controllers/ujian_controller.dart';
import 'package:strict_exam/routing/routes.dart';

// ignore: must_be_immutable
class HomeGuru extends StatelessWidget {
  HomeGuru({super.key});
  UjianController ujianController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          centerTitle: true,
        ),
        body: Obx(() => Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "DAFTAR UJIAN YANG TERSEDIA",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: ujianController.ujianData.length,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Material(
                            elevation: 5,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      ujianController.ujianData[index].judul,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Table(
                                    children: <TableRow>[
                                      TableRow(children: [
                                        const Text("Deskripsi"),
                                        Text(ujianController
                                            .ujianData[index].deskripsi),
                                      ]),
                                      TableRow(children: [
                                        const Text("Waktu mulai"),
                                        Text(ujianController.toDate(
                                            ujianController
                                                .ujianData[index].waktu)),
                                      ]),
                                      TableRow(children: [
                                        const Text("Durasi ujian"),
                                        Text(
                                            "${ujianController.ujianData[index].durasi} menit"),
                                      ]),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: SizedBox(
                                      width: 150,
                                      height: 30,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        child: const Text(
                                          "Lihat Hasil",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        onPressed: () {
                                          Get.toNamed(
                                            AppRoutes.hasilUjianGuru,
                                            arguments: ujianController
                                                .ujianData[index],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                          child: const Icon(Icons.add), onPressed: () {}))
                ],
              ),
            )));
  }
}
