import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/features/exams/controllers/hasil_ujian_controller.dart';

import '../../models/ujian_model.dart';

class HasilUjianSiswa extends StatelessWidget {
  HasilUjianSiswa({super.key});
  HasilUjianSiswaController hasilUjianController = Get.find();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final ujianModel = args[0] as UjianModel;
    final idUser = args[1];

    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        // automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<Hasil>(
          future: hasilUjianController.getHasil(ujianModel.id, idUser),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Hasil hasil = snapshot.data as Hasil;
              String? nilai;
              if (hasil.nilai! % 1 == 0) {
                nilai = hasil.nilai?.toStringAsFixed(0);
              } else {
                nilai = hasil.nilai?.toStringAsFixed(2);
              }
              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      textAlign: TextAlign.center,
                      ujianModel.judul,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Table(
                      children: <TableRow>[
                        TableRow(children: [
                          const Text("Deskripsi"),
                          Text(ujianModel.deskripsi),
                        ]),
                        TableRow(children: [
                          const Text("Waktu mulai"),
                          Text(hasilUjianController
                              .toDate(ujianModel.waktu.toDate())),
                        ]),
                        TableRow(children: [
                          const Text("Durasi ujian"),
                          Text("${ujianModel.durasi} menit"),
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Nilai Ujian",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        nilai.toString(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
