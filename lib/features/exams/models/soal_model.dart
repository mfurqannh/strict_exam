import 'package:cloud_firestore/cloud_firestore.dart';

class SoalModel {
  final String? id;
  final String pertanyaan;
  final String jawaban;

  const SoalModel({
    this.id,
    required this.pertanyaan,
    required this.jawaban,
  });

  //konversi ke bentuk map
  toJson() {
    return {
      "Pertanyaan": pertanyaan,
      "Jawaban": jawaban,
    };
  }

  //map user fetced from firebase to SoalModel
  factory SoalModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return SoalModel(
      id: document.id,
      pertanyaan: data["Pertanyaan"],
      jawaban: data["Jawaban"],
    );
  }
}
