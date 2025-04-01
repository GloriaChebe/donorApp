import 'package:flutter/material.dart';

class PodiumBar extends StatelessWidget {
  final double height;
  final Color color;
  final int rank;
  final String productName;

  PodiumBar({
    required this.height,
    required this.color,
    required this.rank,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            productName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        SizedBox(height: 6),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              "$rank",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}