import 'package:first_app/models/vibe.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/models/place.dart';
import 'package:first_app/models/flock.dart';

class Location {
  final String? id; //@id @default(autoincrement())
  final String name; //@unique
  final List<Vibe>? vibes;
  final List<User>? users;
  final List<Place>? places;
  final List<Flock>? flocks;

  const Location({
    this.id,
    required this.name,
    this.vibes,
    this.users,
    this.places,
    this.flocks,
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
      users: json['users'] != null
          ? (json['users'] as List<dynamic>)
              .map((e) => User.fromJson(e))
              .toList()
          : <User>[],
      places: json['places'] != null
          ? (json['places'] as List<dynamic>)
              .map((e) => Place.fromJson(e))
              .toList()
          : <Place>[],
      flocks: json['flocks'] != null
          ? (json['flocks'] as List<dynamic>)
              .map((e) => Flock.fromJson(e))
              .toList()
          : <Flock>[],
    );
  }
}
