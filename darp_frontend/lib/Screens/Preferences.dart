// // import 'package:flutter/material.dart';
// //
// // class TripScreen extends StatelessWidget {
// //   const TripScreen({super.key});
// //
// //   final List<Map<String, dynamic>> mockTrip = const [
// //     {
// //       "id": 1,
// //       "name": "Church of Nativity",
// //       "duration": "30 min",
// //       "description": "A historic church in Bethlehem.",
// //     },
// //     {
// //       "id": 2,
// //       "name": "Manger Square",
// //       "duration": "20 min",
// //       "description": "Central square in Bethlehem.",
// //     },
// //     {
// //       "id": 3,
// //       "name": "Bethlehem Market",
// //       "duration": "40 min",
// //       "description": "Local traditional market.",
// //     }
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF7F7F7),
// //
// //       // 🟣 APP BAR
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         title: const Text(
// //           "Your Journey",
// //           style: TextStyle(
// //             color: Colors.black,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         centerTitle: false,
// //       ),
// //
// //       // 🟢 BODY
// //       body: Column(
// //         children: [
// //           // 🧭 TRIP HEADER
// //           _buildTripHeader(),
// //
// //           // 🗺 MOCK MAP
// //           _buildMapPlaceholder(),
// //
// //           const SizedBox(height: 10),
// //
// //           // 📍 TIMELINE TITLE
// //           const Padding(
// //             padding: EdgeInsets.symmetric(horizontal: 16),
// //             child: Align(
// //               alignment: Alignment.centerLeft,
// //               child: Text(
// //                 "Your Timeline",
// //                 style: TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //           ),
// //
// //           const SizedBox(height: 10),
// //
// //           // 📜 LIST
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: mockTrip.length,
// //               itemBuilder: (context, index) {
// //                 final site = mockTrip[index];
// //                 return _buildSiteCard(context, site, index);
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // 🟣 TRIP HEADER
// //   Widget _buildTripHeader() {
// //     return Container(
// //       margin: const EdgeInsets.all(16),
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: const Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 "Jerusalem Experience",
// //                 style: TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               SizedBox(height: 4),
// //               Text(
// //                 "3 Places • 1.5 Hours",
// //                 style: TextStyle(color: Colors.grey),
// //               ),
// //             ],
// //           ),
// //           Icon(Icons.map, color: Colors.green, size: 30),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // 🗺 MAP PLACEHOLDER
// //   Widget _buildMapPlaceholder() {
// //     return Container(
// //       margin: const EdgeInsets.symmetric(horizontal: 16),
// //       height: 180,
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(16),
// //         gradient: const LinearGradient(
// //           colors: [Colors.green, Colors.teal],
// //         ),
// //       ),
// //       child: const Center(
// //         child: Text(
// //           "Map Preview (Mock)",
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontSize: 16,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // 📍 SITE CARD
// //   Widget _buildSiteCard(
// //       BuildContext context,
// //       Map<String, dynamic> site,
// //       int index,
// //       ) {
// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (_) => SiteDetailScreen(site: site),
// //           ),
// //         );
// //       },
// //       child: Container(
// //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //         padding: const EdgeInsets.all(16),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(16),
// //         ),
// //         child: Row(
// //           children: [
// //             // index circle
// //             CircleAvatar(
// //               backgroundColor: Colors.green,
// //               child: Text("${index + 1}"),
// //             ),
// //
// //             const SizedBox(width: 12),
// //
// //             // info
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     site["name"],
// //                     style: const TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     site["duration"],
// //                     style: const TextStyle(color: Colors.grey),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //
// //             const Icon(Icons.arrow_forward_ios, size: 16),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
// // class SiteDetailScreen extends StatelessWidget {
// // final Map<String, dynamic> site;
// //
// // const SiteDetailScreen({super.key, required this.site});
// //
// // @override
// // Widget build(BuildContext context) {
// // return Scaffold(
// // appBar: AppBar(
// // title: Text(site["name"]),
// // backgroundColor: Colors.green,
// // ),
// // body: Padding(
// // padding: const EdgeInsets.all(16),
// // child: Column(
// // crossAxisAlignment: CrossAxisAlignment.start,
// // children: [
// // Container(
// // height: 200,
// // decoration: BoxDecoration(
// // color: Colors.grey[300],
// // borderRadius: BorderRadius.circular(16),
// // ),
// // child: const Center(
// // child: Text("Site Image"),
// // ),
// // ),
// //
// // const SizedBox(height: 16),
// //
// // Text(site["name"],
// // style: const TextStyle(
// // fontSize: 22,
// // fontWeight: FontWeight.bold,),),
// //
// // const SizedBox(height: 10),
// //
// // Text(site["description"]),
// //
// // const SizedBox(height: 20),
// //
// // ElevatedButton.icon(
// // onPressed: () {},
// // icon: const Icon(Icons.play_arrow),
// // label: const Text("Play Audio"),
// // style: ElevatedButton.styleFrom(
// // backgroundColor: Colors.green,
// // minimumSize: const Size(double.infinity, 50),),),],),),
// // );}}
//
//
// import 'package:flutter/material.dart';
// import '../models/trip_preferences.dart';
// import '../theme/app_theme.dart';
//
// /// Preferences Screen
// ///
// /// The user picks a Language, one or more Interests, and a Duration,
// /// then taps "Generate My Trip" to move to the Loading Screen.
// ///
// /// Pure UI / form state only — no API calls, no AI. Per the spec
// /// (المهمة السادسة), the result is just handed off as a [TripPreferences]
// /// value; the Loading Screen decides what mock data to show next.
// class PreferencesScreen extends StatefulWidget {
//   const PreferencesScreen({super.key});
//
//   @override
//   State<PreferencesScreen> createState() => _PreferencesScreenState();
// }
//
// class _PreferencesScreenState extends State<PreferencesScreen> {
//   static const List<String> _languages = ['Arabic', 'English', 'French'];
//
//   static const List<String> _interests = [
//     'Religious',
//     'Historical',
//     'Cultural',
//   ];
//   static const List<String> _durations = [
//     '1 Hour',
//     '2 Hours',
//     '3 Hours',
//     '4 Hours',
//     'Full Day',
//   ];
//
//   String? _selectedLanguage = _languages.first; // sensible default
//   final Set<String> _selectedInterests = {};
//   String? _selectedDuration;
//
//   bool get _canSubmit =>
//       _selectedLanguage != null &&
//           _selectedInterests.isNotEmpty &&
//           _selectedDuration != null;
//
//   void _toggleInterest(String interest) {
//     setState(() {
//       if (_selectedInterests.contains(interest)) {
//         _selectedInterests.remove(interest);
//       } else {
//         _selectedInterests.add(interest);
//       }
//     });
//   }
//
//   void _onGenerateTrip() {
//     if (!_canSubmit) return;
//
//     final preferences = TripPreferences(
//       language: _selectedLanguage!,
//       interests: _selectedInterests,
//       duration: _selectedDuration!,
//     );
//
//     // TODO: Loading Screen reads these preferences and, after the mock
//     // delay, navigates to Trip Screen using mock_itinerary.json.
//     Navigator.of(context).pushNamed('/loading', arguments: preferences);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plan Your Trip'),
//         centerTitle: false,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
//                 children: [
//                   Text(
//                     'Tell us what you like',
//                     style: textTheme.titleLarge,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'We\'ll shape your journey around it.',
//                     style: textTheme.bodyMedium,
//                   ),
//                   const SizedBox(height: 28),
//
//                   _SectionTitle('Language'),
//                   const SizedBox(height: 12),
//                   Wrap(
//                     spacing: 10,
//                     runSpacing: 10,
//                     children: _languages.map((language) {
//                       return _SelectableChip(
//                         label: language,
//                         selected: _selectedLanguage == language,
//                         onTap: () =>
//                             setState(() => _selectedLanguage = language),
//                       );
//                     }).toList(),
//                   ),
//
//                   const SizedBox(height: 28),
//
//                   _SectionTitle('Interests'),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Pick as many as you\'d like.',
//                     style: textTheme.bodyMedium,
//                   ),
//                   const SizedBox(height: 12),
//                   Wrap(
//                     spacing: 10,
//                     runSpacing: 10,
//                     children: _interests.map((interest) {
//                       return _SelectableChip(
//                         label: interest,
//                         selected: _selectedInterests.contains(interest),
//                         onTap: () => _toggleInterest(interest),
//                       );
//                     }).toList(),
//                   ),
//
//                   const SizedBox(height: 28),
//
//                   _SectionTitle('Duration'),
//                   const SizedBox(height: 12),
//                   Wrap(
//                     spacing: 10,
//                     runSpacing: 10,
//                     children: _durations.map((duration) {
//                       return _SelectableChip(
//                         label: duration,
//                         selected: _selectedDuration == duration,
//                         onTap: () =>
//                             setState(() => _selectedDuration = duration),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//
//             // --- Bottom CTA ---
//             Padding(
//               padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _canSubmit ? _onGenerateTrip : null,
//                   child: const Text('Generate My Trip'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// Small uppercase-ish label used above each group of chips.
// class _SectionTitle extends StatelessWidget {
//   final String text;
//   const _SectionTitle(this.text);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
//     );
//   }
// }
//
// /// A single tappable chip with a simple animated selected/unselected state.
// /// Reused for Language, Interests, and Duration so all three look and
// /// behave consistently.
// class _SelectableChip extends StatelessWidget {
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//
//   const _SelectableChip({
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 180),
//         curve: Curves.easeOut,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: selected ? AppColors.primary : AppColors.surface,
//           borderRadius: BorderRadius.circular(AppRadius.pill),
//           border: Border.all(
//             color: selected ? AppColors.primary : AppColors.border,
//           ),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: selected ? Colors.white : AppColors.textPrimary,
//             fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
//             fontSize: 14,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/trip_preferences.dart';
import '../theme/app_theme.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  static const List<String> _languages = [
    'Arabic',
    'English',
    'French',
  ];

  static const List<String> _interests = [
    'Religious',
    'Historical',
    'Cultural',
  ];

  String? _selectedLanguage = _languages.first;
  final Set<String> _selectedInterests = {};

  int _selectedHours = 1;
  int _selectedMinutes = 0;

  bool get _canSubmit =>
      _selectedLanguage != null &&
          _selectedInterests.isNotEmpty;

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        _selectedInterests.add(interest);
      }
    });
  }

  void _onGenerateTrip() {
    if (!_canSubmit) return;

    final preferences = TripPreferences(
      language: _selectedLanguage!,
      interests: _selectedInterests,
      duration: "${_selectedHours}h ${_selectedMinutes}m",
    );

    Navigator.of(context).pushNamed(
      '/loading',
      arguments: preferences,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Your Trip'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  8,
                  24,
                  24,
                ),
                children: [
                  Text(
                    'Tell us what you like',
                    style: textTheme.titleLarge,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'We\'ll shape your journey around it.',
                    style: textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 28),

                  // LANGUAGE
                  const _SectionTitle('Language'),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _languages.map((language) {
                      return _SelectableChip(
                        label: language,
                        selected: _selectedLanguage == language,
                        onTap: () {
                          setState(() {
                            _selectedLanguage = language;
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 28),

                  // INTERESTS
                  const _SectionTitle('Interests'),

                  const SizedBox(height: 4),

                  Text(
                    'Pick as many as you\'d like.',
                    style: textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _interests.map((interest) {
                      return _SelectableChip(
                        label: interest,
                        selected:
                        _selectedInterests.contains(interest),
                        onTap: () =>
                            _toggleInterest(interest),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 28),

                  // DURATION
                  const _SectionTitle('Trip Duration'),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time),

                        const SizedBox(width: 16),

                        Expanded(
                          child: DropdownButton<int>(
                            value: _selectedHours,
                            isExpanded: true,
                            underline: const SizedBox(),
                            items: List.generate(
                              13,
                                  (index) => DropdownMenuItem(
                                value: index,
                                child: Text(
                                  '$index Hour${index == 1 ? '' : 's'}',
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedHours = value!;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: DropdownButton<int>(
                            value: _selectedMinutes,
                            isExpanded: true,
                            underline: const SizedBox(),
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text('00 Min'),
                              ),
                              DropdownMenuItem(
                                value: 15,
                                child: Text('15 Min'),
                              ),
                              DropdownMenuItem(
                                value: 30,
                                child: Text('30 Min'),
                              ),
                              DropdownMenuItem(
                                value: 45,
                                child: Text('45 Min'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedMinutes = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Select trip duration in hours and minutes',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                0,
                24,
                20,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                  _canSubmit ? _onGenerateTrip : null,
                  child: const Text(
                    'Generate My Trip',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontSize: 16),
    );
  }
}

class _SelectableChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SelectableChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : AppColors.surface,
          borderRadius: BorderRadius.circular(
            AppRadius.pill,
          ),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected
                ? Colors.white
                : AppColors.textPrimary,
            fontWeight: selected
                ? FontWeight.w600
                : FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}