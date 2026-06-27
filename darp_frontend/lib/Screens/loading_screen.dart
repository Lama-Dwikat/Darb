import 'package:flutter/material.dart';

import '../models/trip_preferences.dart';
import '../services/itinerary_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String _statusMessage = 'Preparing your journey...';

  @override
  void initState() {
    super.initState();
    // Defer so ModalRoute.of(context) is available after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _generateTrip());
  }

  Future<void> _generateTrip() async {
    final preferences =
        ModalRoute.of(context)?.settings.arguments as TripPreferences?;

    if (preferences == null) {
      // No preferences passed — go back to prevent blank trip
      if (mounted) Navigator.pop(context);
      return;
    }

    if (mounted) {
      setState(() => _statusMessage = 'Generating your personalized journey...');
    }

    try {
      final itinerary = await ItineraryService.generateItinerary(preferences);

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        '/trip',
        arguments: itinerary,
      );
    } catch (e) {
      if (!mounted) return;
      _showError(preferences, e.toString().replaceAll('Exception: ', ''));
    }
  }

  void _showError(TripPreferences preferences, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Could not generate trip'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();  // close dialog
              Navigator.of(context).pop();  // back to Preferences
            },
            child: const Text('Go Back'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
              _generateTrip();             // retry
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 24),
              Text(
                _statusMessage,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'This usually takes 5–10 seconds.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
