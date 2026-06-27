import 'package:flutter/material.dart';
import '../models/trip_location.dart';
import '../theme/app_theme.dart';

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
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Name + category badge ──────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    location.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

            // ── Location · Duration · AI Match ────────────────────────────
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 3),
                Flexible(
                  child: Text(
                    location.location,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textSecondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.schedule_outlined,
                    size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 3),
                Text(
                  location.durationLabel,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textSecondary),
                ),
                const Spacer(),
                Text(
                  'AI Match ${location.score}%',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Description ───────────────────────────────────────────────
            Text(
              location.description,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 14),

            // ── CTA ───────────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                child: const Text('View Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
