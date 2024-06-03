import 'package:flutter/material.dart';

class GenderIcon extends StatelessWidget {
  final bool selected;
  final String imagePath;
  final String gender;
  void Function() onPressed;

  GenderIcon({
    required this.selected,
    required this.imagePath,
    required this.gender,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: selected ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            gender, // Replace with the actual gender name
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        // Add some spacing
      ],
    );
  }
}
