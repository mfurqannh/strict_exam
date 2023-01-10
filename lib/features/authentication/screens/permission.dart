import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:strict_exam/features/authentication/screens/masuk.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Center(
            child: SizedBox(
              height: 80,
              width: 200,
              child: Text(
                "Untuk menjalankan aplikasi ini mohon izinkan pengelolaan notifikasi",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                splashFactory: NoSplash.splashFactory),
            child: const Text("Izinkan"),
            onPressed: () async {
              //nyalakan fitur flutter_dnd
              FlutterDnd.gotoPolicySettings();
              // final status = Permission.accessNotificationPolicy.status;
              if (await Permission.accessNotificationPolicy
                  .request()
                  .isGranted) {
                // await FlutterDnd.setInterruptionFilter(FlutterDnd
                //     .INTERRUPTION_FILTER_NONE); // Turn on DND - All notifications are suppressed.
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ));
              }
              //ketika diberi akses, arahkan ke signin
            },
          ),
          const Spacer()
        ],
      ),
    );
  }
}
