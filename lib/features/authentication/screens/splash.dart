import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strict_exam/routing/routes.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logos.png'),
          Row(
            children: [
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                    // ignore: sort_child_properties_last
                    child: const Icon(Icons.arrow_forward),
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    onPressed: () {
                      Get.offNamed(AppRoutes.permissionScreen);
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }
}
