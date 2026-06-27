class TripLocation {
<<<<<<< HEAD
  final String name;
  final String duration;
  final String description;
  final String category;
  final String? imageUrl;
=======
  final String id;
  final String name;
  final String category;
  final int score;
  final int durationMin;
  final String description;
  final String location;
>>>>>>> replit-implementation

  const TripLocation({
    required this.id,
    required this.name,
<<<<<<< HEAD
    required this.duration,
    this.description = '',
    this.category = '',
    this.imageUrl,
  });

  factory TripLocation.fromJson(Map<String, dynamic> json) {
    return TripLocation(
      name: json['name'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
=======
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
>>>>>>> replit-implementation
    );
  }
}
