import 'package:cloud_firestore/cloud_firestore.dart';

class UjianModel {
  String? id;
  String judul;
  String deskripsi;
  int durasi;
  Timestamp waktu;
  List<Pertanyaan>? pertanyaan;
  List<Siswa>? siswa;

  UjianModel({
    this.id,
    required this.judul,
    required this.deskripsi,
    required this.durasi,
    required this.waktu,
    this.pertanyaan,
    this.siswa,
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
  UjianModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document)
      : id = document.id,
        judul = document["Judul"],
        deskripsi = document["Deskripsi"],
        durasi = document["Durasi"],
        waktu = document["Waktu"],
        pertanyaan = [],
        siswa = [];
}

class Pertanyaan {
  String? id;
  String pertanyaan;
  String jawaban;
  String pilihan1;
  String pilihan2;
  String pilihan3;
  String pilihan4;
  String pilihan5;
  String? jawabanSiswa;
  List<Pilihan> pilihan;

  Pertanyaan(
      {this.id,
      required this.pertanyaan,
      required this.jawaban,
      required this.pilihan1,
      required this.pilihan2,
      required this.pilihan3,
      required this.pilihan4,
      required this.pilihan5,
      required this.pilihan});

  Pertanyaan.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        pertanyaan = snapshot["Pertanyaan"],
        jawaban = snapshot["Jawaban"],
        pilihan1 = snapshot["Pilihan1"],
        pilihan2 = snapshot["Pilihan2"],
        pilihan3 = snapshot["Pilihan3"],
        pilihan4 = snapshot["Pilihan4"],
        pilihan5 = snapshot["Pilihan5"],
        pilihan = [];
}

class Pilihan {
  String? id;
  String pilihan;

  Pilihan({this.id, required this.pilihan});

  Pilihan.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        pilihan = snapshot["Pilihan"];
}

class Siswa {
  String? id;
  String idSiswa;
  // num nilai;

  Siswa({this.id, required this.idSiswa});

  toJson() {
    return {"ID Siswa": idSiswa};
  }

  Siswa.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        idSiswa = snapshot["ID Siswa"];
  // nilai = snapshot["Nilai"]
}
