import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/common_widgets/widgets.dart';
import 'package:strict_exam/features/authentication/controllers/getuser_controller.dart';
import 'package:strict_exam/features/authentication/models/user_model.dart';
import 'package:strict_exam/features/exams/controllers/ujian_controller.dart';
import 'package:strict_exam/features/exams/controllers/user_controller.dart';
import 'package:strict_exam/routing/routes.dart';

// ignore: must_be_immutable
class HomeSiswa extends StatelessWidget {
  HomeSiswa({super.key});
  UjianController ujianController = Get.find();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Obx(() => Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "DAFTAR UJIAN YANG TERSEDIA",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: userController.getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            UserModel userdata = snapshot.data as UserModel;
                            // print("id user dari login");
                            // print(controller.user.id);
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: ujianController.ujianData.length,
                              itemBuilder: ((context, index) {
                                // // var hasil = userController.getHasil(
                                // //     ujianController.ujianData[index].id,
                                // //     userdata.id);
                                // print("status");
                                // print(hasil);
                                return Column(
                                  children: [
                                    Material(
                                      elevation: 5,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                ujianController
                                                    .ujianData[index].judul,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Table(
                                              children: <TableRow>[
                                                TableRow(children: [
                                                  const Text("Deskripsi"),
                                                  Text(ujianController
                                                      .ujianData[index]
                                                      .deskripsi),
                                                ]),
                                                TableRow(children: [
                                                  const Text("Waktu mulai"),
                                                  Text(ujianController.toDate(
                                                      ujianController
                                                          .ujianData[index]
                                                          .waktu)),
                                                ]),
                                                TableRow(children: [
                                                  const Text("Durasi ujian"),
                                                  Text(
                                                      "${ujianController.ujianData[index].durasi} menit"),
                                                ]),
                                                // TableRow(children: [
                                                //   const Text("Status"),
                                                //   Text(userdata
                                                //           .hasil?[0].status ??
                                                //       ""),
                                                // ]),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0),
                                              child: SizedBox(
                                                width: 150,
                                                height: 30,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30))),
                                                  child: const Text(
                                                    "Masuk Ujian",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  onPressed: () {
                                                    Get.offNamed(
                                                        AppRoutes.ujian,
                                                        arguments: [
                                                          ujianController
                                                              .ujianData[index],
                                                          userdata.id
                                                        ]);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                            );
                          } else {
                            return Text("Error");
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
              ),
            )));
  }
}
