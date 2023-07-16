import 'package:flutter/material.dart';

class PilihanCard extends StatelessWidget {
  final String pilihan;
  final bool isSelected;
  final VoidCallback onTap;

  const PilihanCard(
      {required this.pilihan,
      this.isSelected = false,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Ink(
          width: 320,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.white,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            pilihan,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
