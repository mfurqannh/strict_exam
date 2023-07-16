import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/repository/ujian_repository/ujian_repository.dart';
import 'package:strict_exam/repository/user_repository/user_repository.dart';

import '../models/ujian_model.dart';

class HasilUjianGuruController extends GetxController {
  final userRepo = Get.put(UserRepository());
  final ujianRepo = Get.put(UjianRepository());

  RxMap<UserModel, Hasil> siswa = RxMap<UserModel, Hasil>();
  final sort = 'Nama'.obs;
  final isAscend = true.obs;
  final icon = Icons.arrow_drop_up.obs;

  Future<Hasil> getHasil(String? idUjian, String? idUser) async {
    final hasil = await userRepo.getUserHasil(idUjian, idUser);
    return hasil;
  }

  Future<Map<UserModel, Hasil>> getSiswa(UjianModel ujianModel) async {
    final list = await ujianRepo.listSiswa(ujianModel);
    final siswa = <UserModel, Hasil>{};

    for (Siswa element in list) {
      final user = await userRepo.getUserbyID(element.idSiswa);
      final hasil = await getHasil(ujianModel.id, element.idSiswa);
      siswa[user] = hasil;
    }
    return siswa;
  }

  sortList(Map<UserModel, Hasil> unSortedSiswa) {
    if (isAscend.value) {
      switch (sort.value) {
        case 'Nama':
          siswa.value = sortNamaAsc(unSortedSiswa);
          break;
        case 'Nilai':
          siswa.value = sortNilaiAsc(unSortedSiswa);
          break;
        case 'Aktiv':
          siswa.value = sortStatusAsc(unSortedSiswa);
          break;
        default:
      }
    } else {
      switch (sort.value) {
        case 'Nama':
          siswa.value = sortNamaDesc(unSortedSiswa);
          break;
        case 'Nilai':
          siswa.value = sortNilaiDesc(unSortedSiswa);
          break;
        case 'Aktiv':
          siswa.value = sortStatusDesc(unSortedSiswa);
          break;
        default:
      }
    }
  }

  sortNamaAsc(Map<UserModel, Hasil> unSortedSiswa) {
    final sortedEntries = unSortedSiswa.entries.toList()
      ..sort(
        (a, b) => (a.key.nama).compareTo(b.key.nama),
      );
    final siswa = Map.fromEntries(sortedEntries);
    return siswa;
  }

  sortNilaiAsc(Map<UserModel, Hasil> unSortedSiswa) {
    final sortedEntries = unSortedSiswa.entries.toList()
      ..sort(
        (a, b) => (a.value.nilai ?? 0).compareTo(b.value.nilai ?? 0),
      );
    final siswa = Map.fromEntries(sortedEntries);
    return siswa;
  }

  sortStatusAsc(Map<UserModel, Hasil> unSortedSiswa) {
    final sortedEntries = unSortedSiswa.entries.toList()
      ..sort(
        (a, b) => a.value.aktv!.compareTo(b.value.aktv!),
      );
    final siswa = Map.fromEntries(sortedEntries);
    return siswa;
  }

  sortNamaDesc(Map<UserModel, Hasil> unSortedSiswa) {
    final sortedEntries = unSortedSiswa.entries.toList()
      ..sort(
        (a, b) => (b.key.nama).compareTo(a.key.nama),
      );
    final siswa = Map.fromEntries(sortedEntries);
    return siswa;
  }

  sortNilaiDesc(Map<UserModel, Hasil> unSortedSiswa) {
    final sortedEntries = unSortedSiswa.entries.toList()
      ..sort(
        (a, b) => (b.value.nilai ?? 0).compareTo(a.value.nilai ?? 0),
      );
    final siswa = Map.fromEntries(sortedEntries);
    return siswa;
  }

  sortStatusDesc(Map<UserModel, Hasil> unSortedSiswa) {
    final sortedEntries = unSortedSiswa.entries.toList()
      ..sort(
        (a, b) => b.value.aktv!.compareTo(a.value.aktv!),
      );
    final siswa = Map.fromEntries(sortedEntries);
    return siswa;
  }

  changeIcon() {
    if (isAscend.value == true) {
      icon.value = Icons.arrow_drop_up;
    } else {
      icon.value = Icons.arrow_drop_down;
    }
  }

  Color getColor(int aktv, String status) {
    if (aktv == 0) {
      return Colors.green;
    } else if (status == "Tidak Selesai") {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }
}
