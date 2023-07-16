import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/features/exams/models/ujian_model.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';
import '../../../repository/ujian_repository/ujian_repository.dart';
import '../../../routing/routes.dart';

class UjianController extends FullLifeCycleController with FullLifeCycleMixin {
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
  RxInt totDurasi = 0.obs;
  int batasKeluar = 0;
  bool forcestop = true;
  String status = "Selesai";
  DateTime keluar = DateTime.now();
  DateTime masuk = DateTime.now();
  DateTime keluardt = DateTime.now();
  DateTime masukdt = DateTime.now();
  Timestamp keluarts = Timestamp.now();
  Timestamp masukts = Timestamp.now();
  Duration durasiD = const Duration(seconds: 0);
  int idAktivitas = 0;
  // Rxn<Future<PermissionStatus>> status = Rxn<Future<PermissionStatus>>();
  // Rx<int?> filter = 0.obs;
  Timer? _timer;
  int sisaDetik = 1;
  final time = '00.00'.obs;

  //JANGAN LUPA DIHAPUS
  RxInt x = 0.obs;
  RxDouble z = 0.0.obs;

  @override
  void onInit() {
    ever(
      x,
      (_) {
        z.value = x.value / allSoal.length * 100;
      },
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    ujianModel = arg[0] as UjianModel;
    forcestop = ujianModel.berhenti!;
    final sekarang = DateTime.now();
    final mulai = ujianModel.waktu.toDate();
    final akhir = mulai.add(Duration(minutes: ujianModel.durasi));
    final durasi = akhir.difference(sekarang).inSeconds;
    batasKeluar = ujianModel.bataswaktu * 60;
    loadData(ujianModel);
    startTimer(durasi);
    // getStatus();
    setDND(FlutterDnd.INTERRUPTION_FILTER_NONE);
    // ever(filter, activateDND);
  }

  @override
  void onClose() {
    setDND(FlutterDnd.INTERRUPTION_FILTER_ALL);
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  Future<void> loadData(UjianModel ujianModel) async {
    final getSoal = await _ujianRepo.getSoal(ujianModel);
    allSoal.assignAll(getSoal!);
    pertanyaanSekarang();
  }

  setDND(int filter) async {
    final status = await Permission.accessNotificationPolicy.status;
    if (status.isGranted) {
      await FlutterDnd.setInterruptionFilter(filter);
    } else if (status.isDenied) {
      FlutterDnd.gotoPolicySettings();
    }
  }

  startTimer(int detik) {
    const duration = Duration(seconds: 1);
    sisaDetik = detik;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (sisaDetik <= 0) {
        timer.cancel();
        Get.defaultDialog(
            title: "Peringatan",
            middleText:
                "Waktu telah habis, jawaban akan disimpan secara otomatis",
            textConfirm: "OK",
            onConfirm: () {
              simpanJawaban();
              Get.delete<UjianController>();
              Get.offNamed(AppRoutes.homeSiswa);
            });
      } else {
        int menit = sisaDetik ~/ 60;
        int detik = (sisaDetik % 60);
        time.value =
            "${menit.toString().padLeft(2, "0")}:${detik.toString().padLeft(2, "0")}";
        sisaDetik--;
      }
    });
  }

  forceStop() {
    Get.defaultDialog(
        title: "Peringatan",
        middleText:
            "Kamu terdetiksi sudah keluar dari aplikasi ujian lebih dari {} menit saat ujian sedang berlangsung",
        textConfirm: "OK",
        onConfirm: () {
          simpanJawaban();
          Get.delete<UjianController>();
          Get.offNamed(AppRoutes.homeSiswa);
        });
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

  pertanyaanTertentu(int i) {
    index.value = i;
    noSoal.value = i + 1;
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
    final nilaiAkhir = Hasil(
        nilai: num.parse(nilai.toStringAsFixed(2)),
        aktv: idAktivitas,
        status: status,
        totDurasi: totDurasi.value);
    final siswa = Siswa(idSiswa: idUser);

    _userRepo.saveNilai(idUser, ujianModel, nilaiAkhir);
    _ujianRepo.addSiswa(ujianModel, siswa);
  }

  @override
  void onDetached() {}

  @override
  void onPaused() {}

  @override
  void onInactive() {
    keluarts = Timestamp.now();
    keluardt = keluarts.toDate();
    keluar = DateTime(keluardt.year, keluardt.month, keluardt.day,
        keluardt.hour, keluardt.minute, keluardt.second);
  }

  @override
  void onResumed() {
    final ujianModel = arg[0] as UjianModel;
    final idUser = arg[1];
    idAktivitas++;

    masukts = Timestamp.now();
    masukdt = masukts.toDate();
    masuk = DateTime(masukdt.year, masukdt.month, masukdt.day, masukdt.hour,
        masukdt.minute, masukdt.second);
    durasiD = masuk.difference(keluar);

    final durasi = durasiD.inSeconds;
    totDurasi.value += durasi;

    final aktivitas =
        Aktivitas(keluar: keluarts, masuk: masukts, durasi: durasi);
    _userRepo.saveAktivitas(
        idUser, ujianModel, idAktivitas.toString(), aktivitas);

    if (forcestop && totDurasi >= batasKeluar) {
      status = "Tidak Selesai";
      forceStop();
    } else {
      // Get.defaultDialog(
      //   title: "Peringatan",
      //   middleText: "Anda melakukan kegiatan yang mencurigakan",
      //   textCancel: "Kembali",
      // );
    }
  }
}
