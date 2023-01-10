import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String nama;
  final String kelas;
  final String email;

  const UserModel({
    this.id,
    required this.nama,
    required this.kelas,
    required this.email,
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
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        nama: data["Nama"],
        kelas: data["Kelas"],
        email: data["Email"]);
  }
}
