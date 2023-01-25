import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/features/exams/controllers/detail_hasil_ujian_guru.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';

// ignore: must_be_immutable
class DetailHasilUjianGuru extends StatelessWidget {
  DetailHasilUjianGuru({super.key});
  DetailHasilUjianGuruController detailController = Get.find();

  @override
  Widget build(BuildContext context) {
    final ujianModel = Get.arguments[0] as UjianModel;
    final siswa = Get.arguments[1] as UserModel;
    final hasil = Get.arguments[2] as Hasil;
    print(siswa.id);
    print(siswa.nama);
    print(ujianModel.id);
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: detailController.getAktivitas(siswa.id, ujianModel.id),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final aktivitas = snapshot.data;
                print(aktivitas!.length);
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Table(
                        children: [
                          TableRow(children: [
                            const Text("Nama"),
                            Text(": ${siswa.nama}"),
                          ]),
                          TableRow(children: [
                            const Text("Kelas"),
                            Text(": ${siswa.kelas}"),
                          ]),
                          TableRow(children: [
                            const Text("Status"),
                            Text(": ${hasil.status}"),
                          ]),
                          TableRow(children: [
                            const Text("Nilai"),
                            Text(": ${hasil.nilai.toString()}"),
                          ]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Log Siswa",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Table(
                              children: [
                                TableRow(children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text("Keluar")),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text("Masuk")),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text("Durasi")),
                                ])
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return Table(
                            children: [
                              TableRow(children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Text(detailController
                                        .toDate(aktivitas[index].keluar!))),
                                Align(
                                    alignment: Alignment.center,
                                    child: Text(detailController
                                        .toDate(aktivitas[index].masuk!))),
                                Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        "${aktivitas[index].durasi.toString()} detik")),
                              ])
                            ],
                          );
                        }),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: aktivitas.length)
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })));
  }
}
