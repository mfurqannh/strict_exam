import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:strict_exam/repository/ujian_repository/ujian_repository.dart';

class BuatSesiUjianController extends GetxController {
  final ujianRepo = Get.put(UjianRepository());

  final judul = TextEditingController();
  final deskripsi = TextEditingController();
  final waktu = TextEditingController();
  final durasi = TextEditingController();
  final jumlah = TextEditingController();
  int bataswaktu = 0;

  RxBool berhenti = false.obs;

  var dateTime;

  Future<DateTime?> pickDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 100));
    if (date != null) {
      final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
              hour: DateTime.now().hour, minute: DateTime.now().minute));
      if (time != null) {
        dateTime =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);
        waktu.text = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
      }
    }
    return dateTime;
  }
}
