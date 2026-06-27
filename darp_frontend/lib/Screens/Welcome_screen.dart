//
//
// import 'package:flutter/material.dart';
// import 'Preferences.dart';
// import '../theme/app_theme.dart';
//
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Spacer(),
//
//               // App Title
//               Text(
//                 "Darb",
//                 style: TextStyle(
//                   fontSize: 38,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//
//               const SizedBox(height: 12),
//
//               // Description
//               Text(
//                 "Your Personalized Journey Through History, Culture & Meaningful Experiences",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.textSecondary,
//                   height: 1.5,
//                 ),
//               ),
//
//               const SizedBox(height: 40),
//
//               // Illustration Card
//               Container(
//                 height: 180,
//                 width: 180,
//                 decoration: BoxDecoration(
//                   color: AppColors.surface,
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(color: AppColors.border),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     )
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.explore_rounded,
//                   size: 80,
//                   color: AppColors.primary,
//                 ),
//               ),
//
//               const Spacer(),
//
//               // Start Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const PreferencesScreen(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: const Text(
//                     "Start Journey",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'Preferences.dart';
import '../theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [

          /// Background decorations
          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.15),
              ),
            ),
          ),

          Positioned(
            bottom: -100,
            left: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withOpacity(0.15),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [

                  const Spacer(),

                  /// Logo
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [

                        Positioned(
                          top: 25,
                          right: 25,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white.withOpacity(0.7),
                            size: 24,
                          ),
                        ),

                        Positioned(
                          bottom: 25,
                          left: 25,
                          child: Icon(
                            Icons.flight_takeoff,
                            color: Colors.white.withOpacity(0.7),
                            size: 24,
                          ),
                        ),

                        const Icon(
                          Icons.explore_rounded,
                          size: 90,
                          color: Colors.white,
                        ),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(20),
                        //   child: Image.asset(
                        //     'assets/images/Darb_logo.png', // <-- your image path
                        //     width: 90,
                        //     height: 90,
                        //     fit: BoxFit.contain,
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// Title
                  Text(
                    "Darb",
                    style: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Subtitle
                  Text(
                    "Discover hidden stories, cultural treasures, and unforgettable journeys tailored just for you.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// Feature Cards
                  Row(
                    children: [

                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.history_edu,
                          title: "History",
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.temple_buddhist,
                          title: "Culture",
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.explore,
                          title: "Adventure",
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// CTA Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const PreferencesScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Start Your Journey",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureCard({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            color: AppColors.primary,
            size: 28,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}