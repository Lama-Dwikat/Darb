import 'package:flutter/material.dart';
<<<<<<< HEAD

import '../models/trip_itinerary.dart';
=======
>>>>>>> replit-implementation
import '../models/trip_location.dart';
import '../theme/app_theme.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen>
    with SingleTickerProviderStateMixin {
  int _transportIndex = 0; // 0 = walking, 1 = driving
  late final AnimationController _ctrl;

  static const List<IconData> _transportIcons = [
    Icons.directions_walk_rounded,
    Icons.directions_car_rounded,
  ];
  static const List<String> _transportLabels = ['Walking', 'Driving'];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String _formatDuration(int totalMin) {
    final h = totalMin ~/ 60;
    final m = totalMin % 60;
    if (h == 0) return '${m}min';
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }

  // Estimated arrival time starting at 09:00, 15 min travel between stops.
  String _arrivalTime(List<TripLocation> locs, int index) {
    int offset = 0;
    for (int i = 0; i < index; i++) {
      offset += locs[i].durationMin + 15;
    }
    final total = 9 * 60 + offset;
    final h = total ~/ 60;
    final m = total % 60;
    final period = h >= 12 ? 'PM' : 'AM';
    final displayH = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$displayH:${m.toString().padLeft(2, '0')} $period';
  }

  // Staggered entrance animation per card.
  Animation<double> _cardAnim(int index, int total) {
    final t = total == 0 ? 1 : total;
    final start = (index / t) * 0.55;
    final end   = (start + 0.45).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _ctrl,
      curve:  Interval(start, end, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final itinerary =
        ModalRoute.of(context)?.settings.arguments as TripItinerary?;

    final List<TripLocation> locations = itinerary?.locations ?? [];
    final String title = itinerary?.title ?? 'Your Journey';
    final String totalDuration = itinerary?.totalDuration ?? '';

    if (locations.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Your Trip')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.map_outlined, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'No locations in your trip.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
=======
    final args = ModalRoute.of(context)?.settings.arguments;
    final List<TripLocation> locations =
        args is List<TripLocation> ? args : [];

    // ── Empty state ──────────────────────────────────────────────────────────
    if (locations.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Your Trip')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.explore_off_rounded,
                  size: 56, color: AppColors.border),
              SizedBox(height: 16),
              Text(
                'No trip available.',
                style: TextStyle(
                    fontSize: 16, color: AppColors.textSecondary),
>>>>>>> replit-implementation
              ),
            ],
          ),
        ),
      );
    }

    final totalMin =
        locations.fold<int>(0, (sum, l) => sum + l.durationMin);

    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(title: const Text('Your Trip')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Trip header card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
=======
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Your Journey')),
      body: CustomScrollView(
        slivers: [
          // ── Journey summary ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: Column(
                children: [
                  // Stats card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color:        AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      border:       Border.all(color: AppColors.border),
                      boxShadow:    AppShadows.card,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _StatPill(
                              icon:  Icons.place_rounded,
                              label: '${locations.length} Stop${locations.length == 1 ? '' : 's'}',
                            ),
                            const SizedBox(width: 10),
                            _StatPill(
                              icon:  Icons.schedule_rounded,
                              label: _formatDuration(totalMin),
                            ),
                            const Spacer(),
                            const Icon(Icons.explore_rounded,
                                color: AppColors.accent, size: 26),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Transportation selector
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color:        AppColors.background,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border:       Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: List.generate(
                              _transportIcons.length,
                              (i) {
                                final selected = _transportIndex == i;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                        () => _transportIndex = i),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                          milliseconds: 200),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                        color: selected
                                            ? AppColors.primary
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                            AppRadius.pill),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            _transportIcons[i],
                                            size:  16,
                                            color: selected
                                                ? Colors.white
                                                : AppColors.textSecondary,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            _transportLabels[i],
                                            style: TextStyle(
                                              fontSize:   13,
                                              fontWeight: FontWeight.w600,
                                              color: selected
                                                  ? Colors.white
                                                  : AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Timeline',
                      style: TextStyle(
                        fontSize:   18,
                        fontWeight: FontWeight.w700,
                        color:      AppColors.textPrimary,
>>>>>>> replit-implementation
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (totalDuration.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.schedule, size: 16),
                          const SizedBox(width: 4),
                          Text(totalDuration),
                        ],
                      ),
                    ],
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4),
                        Text('${locations.length} stops'),
                      ],
                    ),
<<<<<<< HEAD
=======
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // ── Timeline stops ───────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final loc   = locations[index];
                  final anim  = _cardAnim(index, locations.length);
                  final isLast = index == locations.length - 1;

                  return _TimelineStop(
                    location:  loc,
                    stopNumber: index + 1,
                    arrival:   _arrivalTime(locations, index),
                    isLast:    isLast,
                    animation: anim,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/site-details',
                      arguments: loc,
                    ),
                  );
                },
                childCount: locations.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat pill ─────────────────────────────────────────────────────────────────

class _StatPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color:        AppColors.primary10,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border:       Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize:   13,
              fontWeight: FontWeight.w600,
              color:      AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Timeline stop ─────────────────────────────────────────────────────────────

class _TimelineStop extends StatelessWidget {
  final TripLocation location;
  final int stopNumber;
  final String arrival;
  final bool isLast;
  final Animation<double> animation;
  final VoidCallback onTap;

  const _TimelineStop({
    required this.location,
    required this.stopNumber,
    required this.arrival,
    required this.isLast,
    required this.animation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.12, 0),
          end:   Offset.zero,
        ).animate(animation),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Left: number + connector line ──────────────────────────
              SizedBox(
                width: 42,
                child: Column(
                  children: [
                    Container(
                      width:  36,
                      height: 36,
                      decoration: BoxDecoration(
                        color:        AppColors.primary,
                        shape:        BoxShape.circle,
                        boxShadow:    AppShadows.subtle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$stopNumber',
                        style: const TextStyle(
                          color:      Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize:   14,
                        ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin:  Alignment.topCenter,
                              end:    Alignment.bottomCenter,
                              colors: [AppColors.primary, AppColors.border],
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 24),
>>>>>>> replit-implementation
                  ],
                ),
              ),

<<<<<<< HEAD
            const SizedBox(height: 16),

            // Locations list
            Expanded(
              child: ListView.separated(
                itemCount: locations.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
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
=======
              const SizedBox(width: 12),

              // ── Right: stop card ───────────────────────────────────────
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
                    decoration: BoxDecoration(
                      color:        AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border:       Border.all(color: AppColors.border),
                      boxShadow:    AppShadows.card,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Image placeholder ────────────────────────────
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft:    Radius.circular(AppRadius.lg),
                            bottomLeft: Radius.circular(AppRadius.lg),
                          ),
                          child: Container(
                            width: 80,
                            color: categoryBgColor(location.category),
                            child: Center(
                              child: Icon(
                                _categoryIcon(location.category),
                                size:  32,
                                color: categoryTextColor(location.category)
                                    .withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),

                        // ── Content ──────────────────────────────────────
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category badge + arrival
                                Row(
                                  children: [
                                    _CategoryBadge(
                                        category: location.category),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time_rounded,
                                            size:  12,
                                            color: AppColors.textSecondary),
                                        const SizedBox(width: 3),
                                        Text(
                                          arrival,
                                          style: const TextStyle(
                                            fontSize:   11,
                                            color:      AppColors.textSecondary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Name
                                Text(
                                  location.name,
                                  style: const TextStyle(
                                    fontSize:   15,
                                    fontWeight: FontWeight.w700,
                                    color:      AppColors.textPrimary,
                                    height:     1.3,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                // Location
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_rounded,
                                        size:  12,
                                        color: AppColors.textSecondary),
                                    const SizedBox(width: 3),
                                    Expanded(
                                      child: Text(
                                        location.location,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color:    AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Description
                                Text(
                                  location.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color:    AppColors.textSecondary,
                                    height:   1.5,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Duration + match + arrow
                                Row(
                                  children: [
                                    _InfoChip(
                                      icon:  Icons.schedule_rounded,
                                      label: location.durationLabel,
                                    ),
                                    const SizedBox(width: 6),
                                    _InfoChip(
                                      icon:      Icons.star_rounded,
                                      label:     'Match ${location.score}%',
                                      highlight: true,
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward_ios_rounded,
                                        size:  12,
                                        color: AppColors.textSecondary),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
>>>>>>> replit-implementation
              ),
            ],
          ),
        ),
      ),
    );
  }
}
<<<<<<< HEAD
=======

// ── Category icon helper ──────────────────────────────────────────────────────

IconData _categoryIcon(String category) {
  switch (category.toLowerCase()) {
    case 'religious':  return Icons.mosque_rounded;
    case 'historical': return Icons.account_balance_rounded;
    case 'nature':     return Icons.park_rounded;
    case 'culture':    return Icons.theater_comedy_rounded;
    case 'shopping':   return Icons.shopping_bag_rounded;
    case 'food':       return Icons.restaurant_rounded;
    default:           return Icons.place_rounded;
  }
}

// ── Category badge ────────────────────────────────────────────────────────────

class _CategoryBadge extends StatelessWidget {
  final String category;
  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color:        categoryBgColor(category),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize:   11,
          fontWeight: FontWeight.w600,
          color:      categoryTextColor(category),
        ),
      ),
    );
  }
}

// ── Info chip ─────────────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool highlight;

  const _InfoChip({
    required this.icon,
    required this.label,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: highlight ? AppColors.primary08 : AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: highlight ? AppColors.primary30 : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size:  12,
              color: highlight ? AppColors.primary : AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize:   11,
              fontWeight: FontWeight.w600,
              color: highlight ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
>>>>>>> replit-implementation
