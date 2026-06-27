import 'dart:async';
import 'package:flutter/material.dart';
import '../models/trip_preferences.dart';
import '../services/api_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  String? _error;
  int _messageIndex = 0;
  late Timer _messageTimer;
  late AnimationController _progressController;

  static const _messages = [
    '🤖 Analyzing your preferences...',
    '📍 Finding the best attractions...',
    '🗺 Optimizing your itinerary...',
    '✨ Your personalized trip is almost ready...',
  ];

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..forward();

    _messageTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _messageIndex = (_messageIndex + 1) % _messages.length;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _generateTrip());
  }

  @override
  void dispose() {
    _messageTimer.cancel();
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _generateTrip() async {
    final preferences =
        ModalRoute.of(context)!.settings.arguments as TripPreferences;

    final durationMin = _parseDurationMin(preferences.duration);

    try {
      final response = await ApiService().generateTrip(
        interests: preferences.interests.toList(),
        durationMin: durationMin,
        language: preferences.language,
      );

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        '/trip',
        arguments: response.itinerary,
      );
    } catch (e) {
      if (!mounted) return;
      _messageTimer.cancel();
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  int _parseDurationMin(String duration) {
    final parts = duration.split('h ');
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1].replaceAll('m', '').trim()) ?? 0;
    return hours * 60 + minutes;
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    color: Colors.redAccent, size: 48),
                const SizedBox(height: 16),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Darb',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 48),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: Text(
                  _messages[_messageIndex],
                  key: ValueKey(_messageIndex),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              AnimatedBuilder(
                animation: _progressController,
                builder: (context, _) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: _progressController.value,
                          minHeight: 6,
                          backgroundColor: Colors.white12,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF6366F1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${(_progressController.value * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
