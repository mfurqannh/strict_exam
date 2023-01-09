import 'package:flutter/material.dart';
import 'package:strict_exam/views/masuk.dart';

class Permission extends StatelessWidget {
  const Permission({super.key});

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
            onPressed: () {
              //nyalakan fitur flutter_dnd
              //ketika diberi akses, arahkan ke signin
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ));
            },
          ),
          const Spacer()
        ],
      ),
    );
  }
}
