import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/buat_sesi_controller.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:strict_exam/routing/routes.dart';

import '../../../../common_widgets/widgets.dart';

class BuatSesiUjian extends StatelessWidget {
  BuatSesiUjian({super.key});

  BuatSesiUjianController sesiController = Get.find();
  final _formKey = GlobalKey<FormState>();
  var date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      controller: sesiController.judul,
                      validator: (value) {
                        return value!.isEmpty ? "Masukkan Judul" : null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Judul", hintText: "Judul"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      controller: sesiController.deskripsi,
                      validator: (value) {
                        // print("validate");
                        return value!.isEmpty ? "Masukkan Deskripsi" : null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Deskripsi", hintText: "Deskripsi"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      controller: sesiController.jumlah,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        // print("validate");
                        return value!.isEmpty ? "Masukkan Jumlah Soal" : null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Jumlah Soal", hintText: "Jumlah Soal"),
                    ),
                  ),
                  TextFormField(
                    controller: sesiController.waktu,
                    validator: (value) {
                      // print("validate");
                      return value!.isEmpty ? "Masukkan Waktu" : null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Waktu", hintText: "Waktu"),
                    onTap: () async {
                      date = await sesiController.pickDate(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: sesiController.durasi,
                      validator: (value) {
                        return value!.isEmpty ? "Masukkan Durasi" : null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Durasi (Menit)", hintText: "Durasi"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Text(
                        "Buat Soal",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final jumlah = int.parse(sesiController.jumlah.text);
                          final ujianModel = UjianModel(
                              judul: sesiController.judul.text,
                              deskripsi: sesiController.deskripsi.text,
                              durasi: int.parse(sesiController.durasi.text),
                              waktu: Timestamp.fromDate(date!));
                          Get.toNamed(AppRoutes.buatSoal,
                              arguments: [ujianModel, jumlah]);
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
