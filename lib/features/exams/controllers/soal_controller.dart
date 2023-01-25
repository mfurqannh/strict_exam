import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';
import '../../../repository/ujian_repository/ujian_repository.dart';

class SoalController extends FullLifeCycleController with FullLifeCycleMixin {
  final _ujianRepo = Get.put(UjianRepository());
  final _userRepo = Get.put(UserRepository());

  late UjianModel ujianModel;
  final allSoal = <Pertanyaan>[];
  Rxn<Pertanyaan> soalSekarang = Rxn<Pertanyaan>();
  final index = 0.obs;
  final noSoal = 1.obs;
  final jawaban = {};
  bool get isPertama => index.value > 0;
  bool get isTerakhir => index.value < allSoal.length - 1;
  final arg = Get.arguments;
  int skor = 0;
  num nilai = 0;
  DateTime keluardt = DateTime.now();
  DateTime masukdt = DateTime.now();
  Timestamp keluarts = Timestamp.now();
  Timestamp masukts = Timestamp.now();
  Duration durasiD = const Duration(seconds: 0);
  int idAktivitas = 1;
  // Rxn<Future<PermissionStatus>> status = Rxn<Future<PermissionStatus>>();
  // var status = PermissionStatus.denied.obs;

  @override
  void onReady() {
    super.onReady();
    ujianModel = arg[0];
    loadData(ujianModel);
    getDND(FlutterDnd.INTERRUPTION_FILTER_NONE);
    // getStatus();
    // ever(status, activateDND(status.value));
  }

  Future<void> loadData(UjianModel ujianModel) async {
    final getSoal = await _ujianRepo.getSoal(ujianModel);
    allSoal.assignAll(getSoal!);
    pertanyaanSekarang();
  }

  // getStatus() async {
  //   var stat = await Permission.accessNotificationPolicy.status;
  //   status.value = stat as Future<PermissionStatus>?;
  // }

  getDND(int filter) async {
    var status = await Permission.accessNotificationPolicy.status;
    if (status.isGranted) {
      await FlutterDnd.setInterruptionFilter(filter);
    } else if (status.isDenied) {
      FlutterDnd.gotoPolicySettings();
    }
  }

  pertanyaanSekarang() {
    if (allSoal != null && allSoal.isNotEmpty) {
      soalSekarang.value = allSoal[index.value];
    }
  }

  pertanyaanSelanjutnya() {
    if (index.value >= allSoal.length - 1) return;
    index.value++;
    noSoal.value++;
    soalSekarang.value = allSoal[index.value];
  }

  pertanyaanSebelumnya() {
    if (index.value <= 0) return;
    index.value--;
    noSoal.value--;
    soalSekarang.value = allSoal[index.value];
  }

  void setJawaban(String? jawab, String? idSoal) {
    soalSekarang.value!.jawabanSiswa = jawab;
    jawaban[idSoal] = jawab;
    update(["list_pilihan"]);
  }

  void simpanJawaban() {
    final ujianModel = arg[0] as UjianModel;
    final idUser = arg[1];
    final jumlahSoal = ujianModel.pertanyaan?.length;

    jawaban.forEach((key, value) {
      final jawab = Jawaban(jawaban: value);
      _userRepo.saveJawaban(idUser, ujianModel, key, jawab);
    });

    for (Pertanyaan pertanyaan in ujianModel.pertanyaan!) {
      if (pertanyaan.jawaban == jawaban[pertanyaan.id]) {
        skor++;
      }
    }

    nilai = skor / jumlahSoal! * 100;
    final nilaiAkhir =
        Hasil(nilai: num.parse(nilai.toStringAsFixed(2)), status: "Selesai");
    final siswa = Siswa(idSiswa: idUser);

    _userRepo.saveNilai(idUser, ujianModel, nilaiAkhir);
    _ujianRepo.addSiswa(ujianModel, siswa);
  }

  @override
  void onDetached() {
    print("detached");
  }

  @override
  void onInactive() {
    keluarts = Timestamp.now();
    keluardt = keluarts.toDate();
  }

  @override
  void onPaused() {
    print("paused");
  }

  @override
  void onResumed() {
    final ujianModel = arg[0] as UjianModel;
    final idUser = arg[1];

    masukts = Timestamp.now();
    masukdt = masukts.toDate();
    durasiD = masukdt.difference(keluardt);

    final durasi = durasiD.inSeconds;
    final aktivitas =
        Aktivitas(keluar: keluarts, masuk: masukts, durasi: durasi);
    _userRepo.saveAktivitas(
        idUser, ujianModel, idAktivitas.toString(), aktivitas);
    idAktivitas++;

    Get.defaultDialog(
      title: "Peringatan",
      middleText: "Anda melakukan kegiatan yang mencurigakan",
      textCancel: "Kembali",
    );
    print(masukdt);
    print(durasi);
  }
}
