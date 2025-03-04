import 'package:flutter/material.dart';

class DonorHomePage extends StatelessWidget {
  final List<String> urgentProducts = [
    "Rice", "Milk", "Blankets", "Solar Panels", "Medical Kits"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("welcome Gloria")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Urgent Products - Horizontal Scroll
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: urgentProducts.map((product) {
                  return Container(
                    width: 100,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        product,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 20),

            // Ranking Podium
            Text("Top Donated Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 250, child: PodiumChart()),

            SizedBox(height: 20),

            // Continue to Make Donation Button
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/categories');
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Continue to Make Donation", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Podium Chart Widget
class PodiumChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Second place
          PodiumBar(height: 120, color: Colors.amber, rank: 2),
          // First place (tallest in the middle)
          PodiumBar(height: 180, color: Colors.redAccent, rank: 1),
          // Third place
          PodiumBar(height: 100, color: Colors.teal, rank: 3),
        ],
      ),
    );
  }
}

// Podium Bar Widget
class PodiumBar extends StatelessWidget {
  final double height;
  final Color color;
  final int rank;

  PodiumBar({required this.height, required this.color, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "$rank",
          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
