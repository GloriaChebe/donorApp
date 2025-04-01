import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/donatedProduct.dart';
import 'package:flutter_application_1/views/home/podiumBar.dart';


class PodiumChart extends StatelessWidget {
  final List<DonatedProduct> topProducts;

  PodiumChart({required this.topProducts});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Base platform
        Positioned(
          bottom: 0,
          child: Container(
            width: 300,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PodiumBar(
              height: 140,
              color: Colors.amber.shade400,
              rank: 2,
              productName: topProducts[1].name,
            ),
            SizedBox(width: 8),
            PodiumBar(
              height: 200,
              color: Colors.blue,
              rank: 1,
              productName: topProducts[0].name,
            ),
            SizedBox(width: 8),
            PodiumBar(
              height: 120,
              color: Colors.teal.shade400,
              rank: 3,
              productName: topProducts[2].name,
            ),
          ],
        ),
      ],
    );
  }
}