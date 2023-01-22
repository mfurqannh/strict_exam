import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection("Users").add(user.toJson());
  }

  Future<UserModel> getUserData(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<Hasil> getUserHasil(String? idUjian, String? idUser) async {
    final snapshot = await _db
        .collection("Users")
        .doc(idUser)
        .collection("Hasil")
        .doc(idUjian)
        .get();
    final hasilData = Hasil.fromMap(snapshot.data()!);
    return hasilData;
  }

  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  saveJawaban(String idUser, UjianModel ujianModel, String idSoal,
      Jawaban jawaban) async {
    await _db
        .collection("Users")
        .doc(idUser)
        .collection("Hasil")
        .doc(ujianModel.id)
        .collection("Jawaban")
        .doc(idSoal)
        .set(jawaban.toJson());
  }

  saveNilai(String idUser, UjianModel ujianModel, Hasil hasil) async {
    await _db
        .collection("Users")
        .doc(idUser)
        .collection("Hasil")
        .doc(ujianModel.id)
        .set(hasil.toJson());
  }

  saveAktivitas(String idUser, UjianModel ujianModel, String idAktivitas,
      Aktivitas aktivitas) async {
    await _db
        .collection("Users")
        .doc(idUser)
        .collection("Hasil")
        .doc(ujianModel.id)
        .collection("Aktivitas")
        .doc(idAktivitas)
        .set(aktivitas.toJson());
  }
}
