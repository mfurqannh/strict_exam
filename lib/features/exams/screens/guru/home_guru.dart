import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/exams/controllers/list_ujian_controller.dart';
import 'package:strict_exam/features/exams/controllers/user_controller.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:strict_exam/repository/authentication_repository/authentication_repository.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';
import 'package:strict_exam/routing/routes.dart';

// ignore: must_be_immutable
class HomeGuru extends StatelessWidget {
  HomeGuru({super.key});
  ListUjianController ujianController = Get.find();
  AuthenticationRepository authRepo = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () {
                Get.delete<ListUjianController>(force: true);
                authRepo.logout();
              },
              child: const Text(
                "Keluar",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Obx(() => SingleChildScrollView(
            child: Container(
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
                    physics: const ScrollPhysics(),
                    itemCount: ujianController.ujianData.length,
                    itemBuilder: ((context, index) {
                      final waktu =
                          ujianController.ujianData[index].waktu.toDate();
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          children: [
                            Material(
                              elevation: 5,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        ujianController.ujianData[index].judul,
                                        textAlign: TextAlign.center,
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
                                          Text(ujianController.toDate(waktu)),
                                        ]),
                                        TableRow(children: [
                                          const Text("Durasi ujian"),
                                          Text(
                                              "${ujianController.ujianData[index].durasi} menit"),
                                        ]),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12.0),
                                          child: SizedBox(
                                            width: 150,
                                            height: 30,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30))),
                                              child: const Text(
                                                "Lihat Soal",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              onPressed: () {
                                                final ujianModel =
                                                    ujianController
                                                        .ujianData[index];
                                                Get.toNamed(
                                                  AppRoutes.lihatSoal,
                                                  arguments: ujianModel,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12.0),
                                          child: SizedBox(
                                            width: 150,
                                            height: 30,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  backgroundColor:
                                                      Colors.green),
                                              child: const Text(
                                                "Lihat Hasil",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              onPressed: () {
                                                // ignore: unnecessary_cast
                                                final ujianModel =
                                                    ujianController
                                                        .ujianData[index];
                                                Get.toNamed(
                                                  AppRoutes.hasilUjianGuru,
                                                  arguments: ujianModel,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.toNamed(AppRoutes.buatSesi);
          }),
    );
  }
}
