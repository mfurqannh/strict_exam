import 'package:flutter/material.dart';
import 'package:strict_exam/views/permission.dart';

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
          const Spacer(),
          RichText(
            text: const TextSpan(
              text: 'Strict',
              style: TextStyle(fontSize: 50),
              children: <TextSpan>[
                TextSpan(
                    text: 'Exam',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Spacer(),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Permission(),
                          ));
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }
}
