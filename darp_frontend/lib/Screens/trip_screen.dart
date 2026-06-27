import 'package:flutter/material.dart';
import '../models/trip_location.dart';
import '../widgets/locations_card.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  String _formatDuration(int totalMin) {
    final h = totalMin ~/ 60;
    final m = totalMin % 60;
    if (h == 0) return '${m}min';
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final List<TripLocation> locations =
        args is List<TripLocation> ? args : [];

    // ── Empty state ────────────────────────────────────────────────────────
    if (locations.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Your Trip')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.explore_off_rounded, size: 56, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No trip available.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    final totalMin =
        locations.fold<int>(0, (sum, l) => sum + l.durationMin);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Trip summary card ────────────────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Journey',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${locations.length} '
                            'stop${locations.length == 1 ? '' : 's'}'
                            ' · ${_formatDuration(totalMin)}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.explore_rounded,
                        size: 28, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Location cards ───────────────────────────────────────────
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
                        arguments: locations[index],
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
