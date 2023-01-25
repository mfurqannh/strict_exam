import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:strict_exam/routing/routes.dart';
import '../../../authentication/models/user_model.dart';
import '../../controllers/hasil_ujian_guru_controller.dart';

// ignore: must_be_immutable
class HasilUjianGuru extends StatelessWidget {
  HasilUjianGuru({super.key});
  HasilUjianGuruController hasilUjianGuruController = Get.find();

  @override
  Widget build(BuildContext context) {
    final ujianModel = Get.arguments as UjianModel;
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: hasilUjianGuruController.getSiswa(ujianModel),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final siswa = snapshot.data as Map<UserModel, Hasil>;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 15),
                      child: Text(
                        ujianModel.judul,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Table(
                        children: const <TableRow>[
                          TableRow(children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text("Nama"),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text("Kelas"),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text("Nilai"),
                            ),
                          ])
                        ],
                      ),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (((context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.detailHasilUjianGuru,
                                  arguments: [
                                    ujianModel,
                                    siswa.keys.elementAt(index),
                                    siswa.values.elementAt(index)
                                  ]);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Ink(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                ),
                                child: Table(
                                  children: <TableRow>[
                                    TableRow(children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(siswa.keys
                                              .elementAt(index)
                                              .nama)),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(siswa.keys
                                              .elementAt(index)
                                              .kelas)),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(siswa.values
                                              .elementAt(index)
                                              .nilai
                                              .toString())),
                                    ])
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: siswa.length),
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
