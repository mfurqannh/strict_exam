import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/exams/controllers/list_ujian_controller.dart';
import 'package:strict_exam/features/exams/controllers/user_controller.dart';
import 'package:strict_exam/routing/routes.dart';

// ignore: must_be_immutable
class HomeSiswa extends StatelessWidget {
  HomeSiswa({super.key});
  ListUjianController ujianController = Get.find();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                ujianController.getAllUjian();
              },
              icon: const Icon(Icons.refresh)),
          actions: [
            TextButton(
                onPressed: () {
                  Get.delete<ListUjianController>(force: true);
                  Get.delete<UserController>(force: true);
                  userController.signOut();
                },
                child: const Text(
                  "Keluar",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Obx(() => RefreshIndicator(
              onRefresh: () async {
                ujianController.getAllUjian();
              },
              child: SingleChildScrollView(
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
                                // color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: ujianController.ujianData.length,
                        itemBuilder: ((context, index) {
                          final waktuMulai =
                              ujianController.ujianData[index].waktu.toDate();
                          return FutureBuilder(
                            future: ujianController.cekSiswa(
                                ujianController.ujianData[index],
                                userController.user.value.id),
                            builder: (context, snapshot) {
                              bool? isEmpty = snapshot.data;
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      Material(
                                        elevation: 5,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Text(
                                                  ujianController
                                                      .ujianData[index].judul,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Table(
                                                children: <TableRow>[
                                                  TableRow(children: [
                                                    const Text("Deskripsi"),
                                                    Text(ujianController
                                                        .ujianData[index]
                                                        .deskripsi),
                                                  ]),
                                                  TableRow(children: [
                                                    const Text("Waktu mulai"),
                                                    Text(ujianController
                                                        .toDate(waktuMulai)),
                                                  ]),
                                                  TableRow(children: [
                                                    const Text("Durasi ujian"),
                                                    Text(
                                                        "${ujianController.ujianData[index].durasi} menit"),
                                                  ]),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  height: 30,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            isEmpty!
                                                                ? Colors.blue
                                                                : Colors.green,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                    child: Text(
                                                      isEmpty
                                                          ? "Masuk Ujian"
                                                          : "Lihat Hasil",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      isEmpty
                                                          ? Get.dialog(
                                                              AlertDialog(
                                                              scrollable: true,
                                                              title: const Text(
                                                                  "Perhatian"),
                                                              content: Column(
                                                                children: const [
                                                                  Text(
                                                                      "1. Peserta didik mengerjakan soal ujian sesuai dengan waktu yang telah ditentukan\n"
                                                                      "2. Peserta didik diwajibkan untuk terhubung dengan internet\n"
                                                                      "3. Peserta didik dilarang keluar dari halaman ujian sebelum menyelesaikan ujian dengan menekan tombol selesai atau sebelum waktu habis\n"
                                                                      "4. Peserta didik dilarang membuka aplikasi lain selama proses ujian berlangsung\n"
                                                                      "5. Peserta didik dilarang melihat atau membuka notifikasi\n"
                                                                      "6. Peserta didik yang terlambat bergabung dan terlambat membuka soal, maka waktu pengerjaan tetap habis sesuai jadwal yang sudah ditetapkan dan tidak ada penambahan waktu\n"),
                                                                  Text(
                                                                      "Apakah anda sudah siap untuk mengikuti ujian?"),
                                                                ],
                                                              ),
                                                              actions: <Widget>[
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                  child: const Text(
                                                                      "Tidak"),
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    final sekarang =
                                                                        DateTime
                                                                            .now();
                                                                    final mulai =
                                                                        sekarang
                                                                            .isAfter(waktuMulai);
                                                                    mulai
                                                                        ? Get.offNamed(
                                                                            AppRoutes.ujian,
                                                                            arguments: [
                                                                                ujianController.ujianData[index],
                                                                                userController.user.value.id
                                                                              ])
                                                                        : Get.snackbar(
                                                                            "Peringatan",
                                                                            "Waktu ujian belum dimulai");
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                          "Ya"),
                                                                )
                                                              ],
                                                            ))
                                                          : Get.toNamed(
                                                              AppRoutes
                                                                  .hasilUjianSiswa,
                                                              arguments: [
                                                                  ujianController
                                                                          .ujianData[
                                                                      index],
                                                                  userController
                                                                      .user
                                                                      .value
                                                                      .id
                                                                ]);
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
                                } else {
                                  return Column();
                                }
                              } else {
                                return Column();
                              }
                            },
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
              ),
            )));
  }
}
