import 'package:first_app/models/place.dart';
import 'package:first_app/models/vibe.dart';

class Location {
  final int? id; //@id @default(autoincrement())
  final String name; //@unique
  final List<Vibe>? vibes;
  final List<Place>? places;

  const Location({
    this.id,
    required this.name,
    this.vibes,
    this.places,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      vibes: json['vibes'] != null
          ? (json['vibes'] as List<dynamic>)
              .map((e) => Vibe.fromJson(e))
              .toList()
          : <Vibe>[],
      places: json['places'] != null
          ? (json['places'] as List<dynamic>)
              .map((e) => Place.fromJson(e))
              .toList()
          : <Place>[],
    );
  }
}
