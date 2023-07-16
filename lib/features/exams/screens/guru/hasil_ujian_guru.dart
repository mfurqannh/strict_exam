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
  final ujianModel = Get.arguments as UjianModel;

  @override
  Widget build(BuildContext context) {
    final List<String> sortItem = ['Nama', 'Nilai', 'Aktiv'];
    String sort = 'Nama';
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          centerTitle: true,
          actions: [
            SizedBox(
              width: 110,
              child: DropdownButton(
                  isExpanded: true,
                  icon: const Icon(Icons.sort, color: Colors.white),
                  iconSize: 30,
                  items: sortItem.map((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Obx(() => ListTile(
                              title: Text(value),
                              trailing:
                                  Icon(hasilUjianGuruController.icon.value),
                              onTap: () {
                                hasilUjianGuruController.sort.value =
                                    value.toString();
                                hasilUjianGuruController.isAscend.value =
                                    !hasilUjianGuruController.isAscend.value;
                                hasilUjianGuruController.changeIcon();
                              },
                            )));
                  }).toList(),
                  onChanged: (value) {
                    hasilUjianGuruController.sort.value = value.toString();
                    // hasilUjianGuruController.isAscend.value = true;
                  }),
            ),
          ],
        ),
        body: FutureBuilder(
            future: hasilUjianGuruController.getSiswa(ujianModel),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                hasilUjianGuruController.siswa.value =
                    snapshot.data as Map<UserModel, Hasil>;
                return Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 15),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          ujianModel.judul,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        color: Colors.white,
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
                              Align(
                                alignment: Alignment.center,
                                child: Text("Aktivitas"),
                              ),
                            ])
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        hasilUjianGuruController
                            .sortList(hasilUjianGuruController.siswa.value);
                        return Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  // physics: const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (((context, index) {
                                    String? nilai;
                                    if ((hasilUjianGuruController.siswa.values
                                                    .elementAt(index)
                                                    .nilai ??
                                                0) %
                                            1 ==
                                        0) {
                                      nilai = (hasilUjianGuruController
                                                  .siswa.values
                                                  .elementAt(index)
                                                  .nilai ??
                                              0)
                                          .toStringAsFixed(0);
                                    } else {
                                      nilai = (hasilUjianGuruController
                                                  .siswa.values
                                                  .elementAt(index)
                                                  .nilai ??
                                              0)
                                          .toStringAsFixed(2);
                                    }
                                    return InkWell(
                                      onTap: hasilUjianGuruController
                                                  .siswa.values
                                                  .elementAt(index)
                                                  .aktv ==
                                              0
                                          ? null
                                          : () {
                                              Get.toNamed(
                                                  AppRoutes
                                                      .detailHasilUjianGuru,
                                                  arguments: [
                                                    ujianModel,
                                                    hasilUjianGuruController
                                                        .siswa.keys
                                                        .elementAt(index),
                                                    hasilUjianGuruController
                                                        .siswa.values
                                                        .elementAt(index)
                                                  ]);
                                            },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        child: Ink(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 7),
                                            decoration: BoxDecoration(
                                              color: hasilUjianGuruController
                                                  .getColor(
                                                      hasilUjianGuruController
                                                          .siswa.values
                                                          .elementAt(index)
                                                          .aktv!,
                                                      hasilUjianGuruController
                                                          .siswa.values
                                                          .elementAt(index)
                                                          .status!),
                                              border: Border.all(
                                                  color: Colors.blue),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minHeight: 30,
                                                          maxWidth: 80),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        hasilUjianGuruController
                                                            .siswa.keys
                                                            .elementAt(index)
                                                            .nama,
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                ),
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minHeight: 30,
                                                          maxWidth: 30),
                                                  margin: const EdgeInsets.only(
                                                      left: 25),
                                                  height: 22,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          hasilUjianGuruController
                                                              .siswa.keys
                                                              .elementAt(index)
                                                              .kelas)),
                                                ),
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minHeight: 30,
                                                          maxWidth: 45),
                                                  margin: const EdgeInsets.only(
                                                      left: 53),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          nilai.toString())),
                                                ),
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minHeight: 30,
                                                          maxWidth: 40),
                                                  margin: const EdgeInsets.only(
                                                      left: 49),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          (hasilUjianGuruController
                                                                      .siswa
                                                                      .values
                                                                      .elementAt(
                                                                          index)
                                                                      .aktv ??
                                                                  0)
                                                              .toString())),
                                                ),
                                              ],
                                            )),
                                      ),
                                    );
                                  })),
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount:
                                      hasilUjianGuruController.siswa.length),
                            ),
                            // SizedBox(
                            //   height: 100,
                            // )
                          ],
                        );
                      }),
                    ),
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
