import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String nama;
  String kelas;
  String email;
  List<Hasil>? hasil;

  UserModel({
    this.id,
    required this.nama,
    required this.kelas,
    required this.email,
    this.hasil,
  });

  //konversi ke bentuk map
  toJson() {
    return {
      "Nama": nama,
      "Kelas": kelas,
      "Email": email,
    };
  }

  //map user fetced from firebase to usermodel
  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document)
      : id = document.id,
        nama = document["Nama"],
        kelas = document["Kelas"],
        email = document["Email"],
        hasil = [];

  UserModel.fromMap(Map<String, dynamic> map)
      : email = map["Email"],
        nama = map["Nama"],
        kelas = map["Kelas"],
        hasil = [];
}

class Hasil {
  String? id;
  num? nilai;
  List<Aktivitas>? aktivitas;
  List<Jawaban>? jawaban;
  String? status;

  Hasil({this.id, this.nilai, this.aktivitas, this.jawaban, this.status});

  toJson() {
    return {
      "Nilai": nilai,
      "Status": status,
    };
  }

  Hasil.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        nilai = snapshot["Nilai"],
        aktivitas = [],
        jawaban = [],
        status = snapshot["Status"];

  Hasil.fromMap(Map<String, dynamic> map)
      : nilai = map["Nilai"],
        status = map["Status"];
}

class Aktivitas {
  String? id;
  Timestamp? keluar;
  Timestamp? masuk;
  int? durasi;

  Aktivitas({this.id, this.keluar, this.masuk, this.durasi});

  toJson() {
    return {"Keluar": keluar, "Masuk": masuk, "Durasi": durasi};
  }

  Aktivitas.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        keluar = snapshot["Keluar"],
        masuk = snapshot["Masuk"],
        durasi = snapshot["Durasi"];
}

class Jawaban {
  String? id;
  String? jawaban;

  Jawaban({
    this.id,
    this.jawaban,
  });

  toJson() {
    return {
      "Jawaban": jawaban,
    };
  }

  Jawaban.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        jawaban = snapshot["Jawaban"];
}
