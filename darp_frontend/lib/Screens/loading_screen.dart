import 'package:flutter/material.dart';
import '../models/trip_preferences.dart';
import '../services/api_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _generateTrip());
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
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  // Parses "2h 30m" → total minutes.
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

    return const Scaffold(
      backgroundColor: Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Generating your personalized journey...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
