import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/trip_preferences.dart';
import '../theme/app_theme.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  static const List<String> _languages = ['Arabic', 'English', 'French'];
  static const List<String> _interests = ['Religious', 'Historical', 'Cultural'];

  String? _selectedLanguage = _languages.first;
  final Set<String> _selectedInterests = {};

  int _selectedHours   = 1;
  int _selectedMinutes = 0;

  // Budget — local only, not sent to backend
  final _budgetController = TextEditingController(text: '200');

  bool get _canSubmit =>
      _selectedLanguage != null && _selectedInterests.isNotEmpty;

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
      language:  _selectedLanguage!,
      interests: _selectedInterests,
      duration:  '${_selectedHours}h ${_selectedMinutes}m',
    );
    Navigator.of(context).pushNamed('/loading', arguments: preferences);
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Plan Your Trip'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                children: [
                  // ── Welcome card ───────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      border: Border.all(color: AppColors.border),
                      boxShadow: AppShadows.card,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.primary12,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Center(
                                child: Text('🤖',
                                    style: TextStyle(fontSize: 22)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Darb AI',
                                  style: TextStyle(
                                    fontSize:      13,
                                    fontWeight:    FontWeight.w700,
                                    color:         AppColors.primary,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                Text(
                                  'Your personal trip planner',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:    AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Hello!',
                          style: TextStyle(
                            fontSize:   22,
                            fontWeight: FontWeight.w800,
                            color:      AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "I'll build a personalized itinerary based on your interests, budget and available time.",
                          style: TextStyle(
                            fontSize: 15,
                            color:    AppColors.textSecondary,
                            height:   1.55,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Budget ─────────────────────────────────────────────────
                  _ConvoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _QuestionLabel(
                          emoji: '💰',
                          question: 'What is your available budget?',
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _budgetController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: const TextStyle(
                                  fontSize:   16,
                                  color:      AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: const InputDecoration(
                                  hintText: '200',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color:  AppColors.primary10,
                                borderRadius: BorderRadius.circular(AppRadius.md),
                                border: Border.all(color: AppColors.primary30),
                              ),
                              child: const Text(
                                'JOD',
                                style: TextStyle(
                                  color:      AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize:   15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Duration ───────────────────────────────────────────────
                  _ConvoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _QuestionLabel(
                          emoji: '⏰',
                          question: 'How long is your trip?',
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color:        AppColors.background,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            border:       Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: AppColors.primary, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DropdownButton<int>(
                                  value:      _selectedHours,
                                  isExpanded: true,
                                  underline:  const SizedBox(),
                                  dropdownColor: AppColors.surface,
                                  style: const TextStyle(
                                    color:    AppColors.textPrimary,
                                    fontSize: 15,
                                  ),
                                  items: List.generate(
                                    13,
                                    (i) => DropdownMenuItem(
                                      value: i,
                                      child: Text(
                                          '$i Hour${i == 1 ? '' : 's'}'),
                                    ),
                                  ),
                                  onChanged: (v) =>
                                      setState(() => _selectedHours = v!),
                                ),
                              ),
                              Container(
                                  width: 1, height: 28, color: AppColors.border),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DropdownButton<int>(
                                  value:      _selectedMinutes,
                                  isExpanded: true,
                                  underline:  const SizedBox(),
                                  dropdownColor: AppColors.surface,
                                  style: const TextStyle(
                                    color:    AppColors.textPrimary,
                                    fontSize: 15,
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                        value: 0,  child: Text('00 Min')),
                                    DropdownMenuItem(
                                        value: 15, child: Text('15 Min')),
                                    DropdownMenuItem(
                                        value: 30, child: Text('30 Min')),
                                    DropdownMenuItem(
                                        value: 45, child: Text('45 Min')),
                                  ],
                                  onChanged: (v) =>
                                      setState(() => _selectedMinutes = v!),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Interests ──────────────────────────────────────────────
                  _ConvoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _QuestionLabel(
                          emoji: '🎯',
                          question: 'What are you interested in?',
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Pick as many as you\'d like.',
                          style: TextStyle(
                            fontSize: 13,
                            color:    AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing:    10,
                          runSpacing: 10,
                          children: _interests.map((interest) {
                            return _SelectableChip(
                              label:    interest,
                              selected: _selectedInterests.contains(interest),
                              onTap:    () => _toggleInterest(interest),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Language ───────────────────────────────────────────────
                  _ConvoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _QuestionLabel(
                          emoji: '🌐',
                          question: 'Preferred language?',
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing:    10,
                          runSpacing: 10,
                          children: _languages.map((language) {
                            return _SelectableChip(
                              label:    language,
                              selected: _selectedLanguage == language,
                              onTap:    () => setState(
                                  () => _selectedLanguage = language),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Generate button ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canSubmit ? _onGenerateTrip : null,
                  child: const Text('✨  Generate My Trip'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared layout helpers ─────────────────────────────────────────────────────

class _ConvoCard extends StatelessWidget {
  final Widget child;
  const _ConvoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border:       Border.all(color: AppColors.border),
        boxShadow:    AppShadows.subtle,
      ),
      child: child,
    );
  }
}

class _QuestionLabel extends StatelessWidget {
  final String emoji;
  final String question;
  const _QuestionLabel({required this.emoji, required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 8),
        Text(
          question,
          style: const TextStyle(
            fontSize:   16,
            fontWeight: FontWeight.w700,
            color:      AppColors.textPrimary,
            height:     1.3,
          ),
        ),
      ],
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
        duration: const Duration(milliseconds: 200),
        curve:    Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: selected ? AppShadows.subtle : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color:      selected ? Colors.white : AppColors.textPrimary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            fontSize:   14,
          ),
        ),
      ),
    );
  }
}
