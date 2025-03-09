import 'package:flutter/material.dart';

class SimpleWidget extends StatelessWidget {
  const SimpleWidget({super.key, required this.label, required this.color});

  final String label;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
        ],
      ),
    );
  }
}