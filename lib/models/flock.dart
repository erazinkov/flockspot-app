import 'package:first_app/models/availability.dart';
import 'package:first_app/models/event.dart';
import 'package:first_app/models/meet.dart';
import 'package:first_app/models/place.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/models/vibe.dart';

class Flock {
  final int? id; //@id @default(autoincrement())
  final int flockSize;
  final String? name;
  final DateTime? nearestDate;
  final int? locationId;
  final int? location;
  final int? aroundEventId;
  final Event? aroundEvent;
  final List<Vibe>? vibes;
  final List<Meet>? meets;
  final List<User>? users;
  final List<Place>? suggestedPlaces;
  final List<Availability>? suggestedAvailability;

  const Flock({
    this.id,
    required this.flockSize,
    this.name,
    this.nearestDate,
    this.locationId,
    this.location,
    this.aroundEventId,
    this.aroundEvent,
    this.vibes,
    this.meets,
    this.users,
    this.suggestedPlaces,
    this.suggestedAvailability,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flockSize': flockSize,
      'name': name,
    };
  }

  factory Flock.fromJson(Map<String, dynamic> json) {
    return Flock(
      id: json['id'],
      flockSize: json['flockSize'],
      name: json['name'],
      locationId: json['locationId'],
      location: json['location'],
      aroundEventId: json['aroundEventId'],
      aroundEvent: json['aroundEvent'],
      vibes: json['vibes'],
      meets: json['meets'],
      users: json['users'],
      suggestedPlaces: json['suggestedPlaces'],
      suggestedAvailability: json['suggestedAvailability'],
    );
  }
}
