import 'package:flutter/material.dart';

class NoSoal extends StatelessWidget {
  final String nomor;
  final bool isSelected;
  final bool isEmpty;
  final VoidCallback onTap;

  const NoSoal(
      {required this.nomor,
      this.isSelected = false,
      this.isEmpty = true,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.blue;
    Color fgColor = Colors.blue;
    Color brColor = Colors.blue;

    if (isSelected) {
      bgColor = Colors.green;
      fgColor = Colors.white;
    } else {
      bgColor = Colors.blue;
      fgColor = Colors.white;
    }
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
        ),
        child: Text(nomor));
  }
}
