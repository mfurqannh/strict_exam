import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/exams/controllers/soal_controller.dart';

class Ujian extends GetView<SoalController> {
  const Ujian({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Pertanyaan:"),
      ),
    );
  }
}
