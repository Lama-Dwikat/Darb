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