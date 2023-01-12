import 'package:cloud_firestore/cloud_firestore.dart';

class UjianModel {
  final String? id;
  final String judul;
  final String deskripsi;
  final int durasi;
  final Timestamp waktu;

  const UjianModel({
    this.id,
    required this.judul,
    required this.deskripsi,
    required this.durasi,
    required this.waktu,
  });

  //konversi ke bentuk map
  toJson() {
    return {
      "Judul": judul,
      "Deskripsi": deskripsi,
      "Durasi": durasi,
      "Waktu": waktu,
    };
  }

  //map user fetced from firebase to UjianModel
  factory UjianModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UjianModel(
        id: document.id,
        judul: data["Judul"],
        deskripsi: data["Deskripsi"],
        durasi: data["Durasi"],
        waktu: data["Waktu"]);
  }
}
