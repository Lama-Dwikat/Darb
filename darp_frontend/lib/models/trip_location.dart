class TripLocation {
  final String id;
  final String name;
  final String category;
  final int score;
  final int durationMin;
  final String description;
  final String location;

  const TripLocation({
    required this.id,
    required this.name,
    required this.category,
    required this.score,
    required this.durationMin,
    required this.description,
    required this.location,
  });

  String get durationLabel => '$durationMin min';

  factory TripLocation.fromJson(Map<String, dynamic> json) {
    return TripLocation(
      id:          json['id']           as String,
      name:        json['name']         as String,
      category:    json['category']     as String,
      score:       json['score']        as int,
      durationMin: json['duration_min'] as int,
      description: json['description']  as String,
      location:    json['location']     as String,
    );
  }
}
