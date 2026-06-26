import 'package:flutter/material.dart';

class SiteDetailsScreen extends StatelessWidget {
  const SiteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Site Details",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 220,
              width: double.infinity,
              color: Colors.grey.shade300,

              child: const Center(
                child: Text(
                  "Image Placeholder",
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Church of Nativity",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Story Placeholder",
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: null,
              child: const Text(
                "Play Audio",
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Suggested Services",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Coming Soon",
            ),
          ],
        ),
      ),
    );
  }
}