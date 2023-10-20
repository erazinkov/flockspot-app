import 'dart:convert';

import 'package:first_app/models/availability.dart';
import 'package:first_app/models/event.dart';
import 'package:first_app/models/flock_users.dart';
import 'package:first_app/models/location.dart';
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
  final Location? location;
  final int? aroundEventId;
  final Event? aroundEvent;
  final List<Vibe>? vibes;
  final List<dynamic>? meets;
  final List<FlockUsers>? users;
  final List<dynamic>? suggestedPlaces;
  final List<dynamic>? suggestedAvailability;

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

  factory Flock.fromJson(Map<String, dynamic> json) {
    return Flock(
      id: json['id'],
      flockSize: json['flockSize'],
      name: json['name'],
      locationId: json['locationId'],
      location: Location.fromJson(json['location']),
      aroundEventId: json['aroundEventId'],
      aroundEvent: json['aroundEvent'],
      vibes: (json['vibes'] as List<dynamic>)
          .map((e) => Vibe.fromJson(e))
          .toList(),
      meets: json['meets'],
      users: (json['users'] as List<dynamic>)
          .map((e) => FlockUsers.fromJson(e))
          .toList(),
      suggestedPlaces: json['suggestedPlaces'],
      suggestedAvailability: json['suggestedAvailability'],
    );
  }
}
