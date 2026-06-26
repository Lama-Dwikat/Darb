import 'package:flutter/material.dart';

import '../models/trip_location.dart';
import '../widgets/locations_card.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<TripLocation> locations = [

      const TripLocation(
        name: "Church of Nativity",
        duration: "30 min",
      ),

      const TripLocation(
        name: "Manger Square",
        duration: "20 min",
      ),

      const TripLocation(
        name: "Bethlehem Market",
        duration: "40 min",
      ),
    ];

    // Empty State

    if (locations.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No Trip Available",
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Trip",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [

                    Text(
                      "Bethlehem Journey",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text("3 Hours"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {

                  return LocationCard(

                    location: locations[index],

                    onPressed: () {

                      Navigator.pushNamed(
                        context,
                        '/site-details',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}