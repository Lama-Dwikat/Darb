class TripPreferences {
  final String language;
  final Set<String> interests;
  final String duration;

  const TripPreferences({
    required this.language,
    required this.interests,
    required this.duration,
  });

  @override
  String toString() =>
      'TripPreferences(language: $language, interests: $interests, duration: $duration)';
}
