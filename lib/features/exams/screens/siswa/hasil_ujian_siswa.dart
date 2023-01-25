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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(hasil.status.toString()),
                    Text(
                      hasil.nilai.toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       Get.back();
                    //     },
                    //     child: Text("Kembali"))
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("Anda belum melaksanakan ujian"),
              );
            }
          }),
    );
  }
}
