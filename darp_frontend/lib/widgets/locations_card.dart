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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color:        AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border:       Border.all(color: AppColors.border),
          boxShadow:    AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Name + category badge ────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    location.name,
                    style: const TextStyle(
                      fontSize:   16,
                      fontWeight: FontWeight.w700,
                      color:      AppColors.textPrimary,
                      height:     1.3,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: categoryBgColor(location.category),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    location.category,
                    style: TextStyle(
                      fontSize:   11,
                      fontWeight: FontWeight.w600,
                      color:      categoryTextColor(location.category),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ── Location · Duration · AI Match ───────────────────────────
            Row(
              children: [
                const Icon(Icons.location_on_rounded,
                    size: 13, color: AppColors.textSecondary),
                const SizedBox(width: 3),
                Flexible(
                  child: Text(
                    location.location,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.schedule_rounded,
                    size: 13, color: AppColors.textSecondary),
                const SizedBox(width: 3),
                Text(
                  location.durationLabel,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color:        AppColors.primary10,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border:       Border.all(color: AppColors.primary30),
                  ),
                  child: Text(
                    'Match ${location.score}%',
                    style: const TextStyle(
                      fontSize:   11,
                      fontWeight: FontWeight.w600,
                      color:      AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Description ──────────────────────────────────────────────
            Text(
              location.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color:    AppColors.textSecondary,
                height:   1.5,
              ),
            ),

            const SizedBox(height: 14),

            // ── CTA ──────────────────────────────────────────────────────
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
