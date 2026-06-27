import 'package:flutter/material.dart';
import '../models/trip_location.dart';

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

    if (locations.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F172A),
          title: const Text('Your Trip', style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.explore_off_rounded, size: 56, color: Colors.white24),
              SizedBox(height: 16),
              Text('No trip available.',
                  style: TextStyle(fontSize: 16, color: Colors.white38)),
            ],
          ),
        ),
      );
    }

    final totalMin = locations.fold<int>(0, (sum, l) => sum + l.durationMin);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: const Text('Your Trip', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            // ── Summary bar ───────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  _SummaryStat(
                    icon: Icons.place_rounded,
                    label: 'Total Stops',
                    value: '${locations.length}',
                  ),
                  Container(
                    width: 1,
                    height: 36,
                    color: Colors.white12,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  _SummaryStat(
                    icon: Icons.schedule_rounded,
                    label: 'Total Duration',
                    value: _formatDuration(totalMin),
                  ),
                  const Spacer(),
                  const Icon(Icons.explore_rounded,
                      color: Color(0xFF6366F1), size: 28),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Location cards ────────────────────────────────────────────
            Expanded(
              child: ListView.separated(
                itemCount: locations.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _LocationCard(
                    location: locations[index],
                    stopNumber: index + 1,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/site-details',
                      arguments: locations[index],
                    ),
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

class _SummaryStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF6366F1), size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(color: Colors.white38, fontSize: 11)),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

class _LocationCard extends StatelessWidget {
  final TripLocation location;
  final int stopNumber;
  final VoidCallback onTap;

  const _LocationCard({
    required this.location,
    required this.stopNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top row: stop number + name + match badge ─────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$stopNumber',
                    style: const TextStyle(
                      color: Color(0xFF6366F1),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    location.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Match Score • ${location.score}%',
                    style: const TextStyle(
                      color: Color(0xFF22C55E),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Category + Duration ───────────────────────────────────
            Row(
              children: [
                _Chip(
                  icon: Icons.category_rounded,
                  label: location.category,
                ),
                const SizedBox(width: 8),
                _Chip(
                  icon: Icons.schedule_rounded,
                  label: location.durationLabel,
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Description ───────────────────────────────────────────
            Text(
              location.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 13,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 10),

            // ── Location ──────────────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.location_on_rounded,
                    size: 14, color: Colors.white38),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    location.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 12, color: Colors.white24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Chip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white54),
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}
