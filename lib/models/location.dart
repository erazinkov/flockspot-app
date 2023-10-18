import 'package:first_app/models/place.dart';
import 'package:first_app/models/vibe.dart';

class Location {
  final int id; //@id @default(autoincrement())
  final String name; //@unique
  final List<Vibe>? vibes;
  final List<Place>? places;

  const Location({
    required this.id,
    required this.name,
    this.vibes,
    this.places,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      vibes: json['vibes'],
      places: json['places'],
    );
  }
}
