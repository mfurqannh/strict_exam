import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/exams/controllers/ujian_controller.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:strict_exam/routing/routes.dart';

class HomeSiswa extends StatelessWidget {
  HomeSiswa({super.key});
  final controller = Get.put(UjianController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          centerTitle: true,
        ),
        body: Container(
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
              FutureBuilder<List<UjianModel>>(
                  future: controller.getAllUjian(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text(
                                              snapshot.data![index].judul,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Table(
                                            children: <TableRow>[
                                              TableRow(children: [
                                                const Text("Deskripsi"),
                                                Text(snapshot
                                                    .data![index].deskripsi),
                                              ]),
                                              TableRow(children: [
                                                const Text("Waktu mulai"),
                                                Text(controller.toDate(snapshot
                                                    .data![index].waktu)),
                                              ]),
                                              TableRow(children: [
                                                const Text("Durasi ujian"),
                                                Text(
                                                    "${snapshot.data![index].durasi.toString()} menit"),
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                child: const Text(
                                                  "Masuk Ujian",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                onPressed: () {
                                                  Get.toNamed(AppRoutes.ujian,
                                                      arguments: snapshot
                                                          .data![index].id);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              );
                            }));
                      } else {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
            ],
          ),
        ));
  }
}
