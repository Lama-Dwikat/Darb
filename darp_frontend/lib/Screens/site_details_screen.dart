import 'package:flutter/material.dart';

import '../models/trip_location.dart';

class SiteDetailsScreen extends StatelessWidget {
  const SiteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final location =
        ModalRoute.of(context)?.settings.arguments as TripLocation?;

    final name = location?.name ?? 'Site Details';
    final description = location?.description ?? '';
    final duration = location?.duration ?? '';
    final category = location?.category ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Site image placeholder (ready for real imageUrl)
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.location_city,
                  size: 72,
                  color: Colors.grey.shade400,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Site name
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Category + duration chips
            if (category.isNotEmpty || duration.isNotEmpty)
              Wrap(
                spacing: 8,
                children: [
                  if (category.isNotEmpty)
                    Chip(
                      avatar: const Icon(Icons.label_outline, size: 16),
                      label: Text(category),
                      visualDensity: VisualDensity.compact,
                    ),
                  if (duration.isNotEmpty)
                    Chip(
                      avatar: const Icon(Icons.schedule, size: 16),
                      label: Text(duration),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),

            const SizedBox(height: 16),

            // Description
            if (description.isNotEmpty)
              Text(
                description,
                style: const TextStyle(fontSize: 15, height: 1.7),
              )
            else
              const Text(
                'No description available.',
                style: TextStyle(color: Colors.grey),
              ),

            const SizedBox(height: 32),

            const Divider(),

            const SizedBox(height: 16),

            const Text(
              'Suggested Services',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 8),

            const Text(
              'Guided tours, local restaurants, and transport options coming soon.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
