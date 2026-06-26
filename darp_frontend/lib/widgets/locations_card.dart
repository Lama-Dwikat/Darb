import 'package:flutter/material.dart';
import '../models/trip_location.dart';

class LocationCard extends StatelessWidget {

  final TripLocation location;
  final VoidCallback onPressed;

  const LocationCard({
    super.key,
    required this.location,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Text(
              location.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(location.duration),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: onPressed,
              child: const Text(
                "View Details",
              ),
            ),
          ],
        ),
      ),
    );
  }
}