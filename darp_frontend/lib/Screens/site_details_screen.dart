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
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Site Details')),
        body: const Center(
          child: Text('No details available.',
              style: TextStyle(color: AppColors.textSecondary)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Hero image sliver app bar ────────────────────────────────────
          SliverAppBar(
            expandedHeight: 280,
            pinned:         true,
            backgroundColor: AppColors.secondary,
            iconTheme:      const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient placeholder (replace with Image.network when ready)
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin:  Alignment.topLeft,
                        end:    Alignment.bottomRight,
                        colors: [
                          Color(0xFF8A6A3D),
                          Color(0xFFC7922F),
                        ],
                      ),
                    ),
                  ),
                  const Center(
                    child: Icon(
                      Icons.image_outlined,
                      size:  72,
                      color: Colors.white30,
                    ),
                  ),
                  // Bottom gradient fade to background
                  Positioned(
                    bottom: 0, left: 0, right: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin:  Alignment.bottomCenter,
                          end:    Alignment.topCenter,
                          colors: [
                            AppColors.background,
                            const Color(0x00F7F2EA),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category badge + location row
                  Row(
                    children: [
                      _CategoryBadge(category: location.category),
                      const SizedBox(width: 10),
                      const Icon(Icons.location_on_rounded,
                          size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          location.location,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color:    AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Title
                  Text(
                    location.name,
                    style: const TextStyle(
                      fontSize:      26,
                      fontWeight:    FontWeight.w800,
                      color:         AppColors.textPrimary,
                      height:        1.2,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Duration + Match Score row
                  Row(
                    children: [
                      _MetaBadge(
                        icon:  Icons.schedule_rounded,
                        label: location.durationLabel,
                      ),
                      const SizedBox(width: 10),
                      _MetaBadge(
                        icon:      Icons.star_rounded,
                        label:     'Match Score ${location.score}%',
                        highlight: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color:        AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      border:       Border.all(color: AppColors.border),
                      boxShadow:    AppShadows.subtle,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About this place',
                          style: TextStyle(
                            fontSize:   15,
                            fontWeight: FontWeight.w700,
                            color:      AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          location.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color:    AppColors.textSecondary,
                            height:   1.65,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Audio guide card
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color:        AppColors.primary10,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      border:       Border.all(color: AppColors.primary30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width:  44,
                          height: 44,
                          decoration: BoxDecoration(
                            color:  AppColors.primary,
                            shape:  BoxShape.circle,
                          ),
                          child: const Icon(Icons.play_arrow_rounded,
                              color: Colors.white, size: 22),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Audio Guide',
                                style: TextStyle(
                                  fontSize:   14,
                                  fontWeight: FontWeight.w700,
                                  color:      AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Listen to the full story of this site',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:    AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Coming Soon',
                          style: TextStyle(
                            fontSize:   11,
                            color:      AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Suggested services
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color:        AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      border:       Border.all(color: AppColors.border),
                      boxShadow:    AppShadows.subtle,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width:  44,
                          height: 44,
                          decoration: BoxDecoration(
                            color:        AppColors.border,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: const Icon(Icons.room_service_rounded,
                              color: AppColors.secondary, size: 22),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Suggested Services',
                                style: TextStyle(
                                  fontSize:   14,
                                  fontWeight: FontWeight.w700,
                                  color:      AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Tours, guides, and more',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:    AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Coming Soon',
                          style: TextStyle(
                            fontSize:   11,
                            color:      AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Start Navigation CTA
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon:  const Icon(Icons.navigation_rounded),
                      label: const Text('Start Navigation'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Category badge ────────────────────────────────────────────────────────────

class _CategoryBadge extends StatelessWidget {
  final String category;
  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color:        categoryBgColor(category),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize:   12,
          fontWeight: FontWeight.w600,
          color:      categoryTextColor(category),
        ),
      ),
    );
  }
}

// ── Meta badge ────────────────────────────────────────────────────────────────

class _MetaBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool highlight;

  const _MetaBadge({
    required this.icon,
    required this.label,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color:  highlight ? AppColors.primary10 : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: highlight ? AppColors.primary30 : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size:  14,
              color: highlight ? AppColors.primary : AppColors.textSecondary),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize:   13,
              fontWeight: FontWeight.w600,
              color: highlight ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
