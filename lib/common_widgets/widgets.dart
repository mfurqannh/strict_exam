import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: const TextSpan(
      style: TextStyle(fontSize: 20),
      children: <TextSpan>[
        TextSpan(text: 'Strict', style: TextStyle(fontWeight: FontWeight.w500)),
        TextSpan(text: 'Exam', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
