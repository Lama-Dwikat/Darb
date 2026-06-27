import 'package:flutter/material.dart';
import '../models/trip_location.dart';
import '../theme/app_theme.dart';

class SiteDetailsScreen extends StatelessWidget {
  const SiteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final location =
        ModalRoute.of(context)?.settings.arguments as TripLocation?;

    if (location == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Site Details')),
        body: const Center(child: Text('No details available.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image placeholder ────────────────────────────────────────
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const Center(
                child: Icon(
                  Icons.image_outlined,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Name ─────────────────────────────────────────────────────
            Text(
              location.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),

            // ── Location + category ──────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  location.location,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0x1AB07D45),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    location.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ── Duration + AI Match ──────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.schedule_outlined,
                    size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  location.durationLabel,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(width: 16),
                Text(
                  'AI Match ${location.score}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Description ──────────────────────────────────────────────
            const Text(
              'About this place',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              location.description,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 28),

            // ── Audio CTA ────────────────────────────────────────────────
            ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Play Audio'),
            ),

            const SizedBox(height: 28),

            // ── Suggested services ───────────────────────────────────────
            const Text(
              'Suggested Services',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Coming Soon',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
