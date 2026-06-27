import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/trip_preferences.dart';
import '../models/trip_itinerary.dart';

class ItineraryService {
  static String get _baseUrl {
    if (kIsWeb) {
      // When served by the Node.js backend on the same origin,
      // use a root-relative path so it works in every environment.
      return '/api';
    }
    return 'http://localhost:5000/api';
  }

  static Future<TripItinerary> generateItinerary(
      TripPreferences preferences) async {
    final uri = Uri.parse('$_baseUrl/generateItinerary');

    final response = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'language': preferences.language,
            'interests': preferences.interests.toList(),
            'duration': preferences.duration,
          }),
        )
        .timeout(const Duration(seconds: 45));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return TripItinerary.fromJson(data);
    }

    String errorMessage = 'Failed to generate itinerary (${response.statusCode})';
    try {
      final errBody = jsonDecode(response.body) as Map<String, dynamic>;
      errorMessage = errBody['error'] as String? ?? errorMessage;
    } catch (_) {}
    throw Exception(errorMessage);
  }
}
