import 'package:first_app/models/event.dart';
import 'package:first_app/models/flock_temp.dart';
import 'package:first_app/models/location.dart';
import 'package:first_app/models/meet.dart';
import 'package:first_app/models/place_availability.dart';
import 'package:first_app/models/vibe.dart';

class Place {
  final int id; //@id @default(autoincrement())
  final String title;
  final bool isPublic;
  final bool? isApproved;
  final String? description;
  final String? preview;
  final int locationId;
  final Location
      location; //@relation(fields: [locationId], references: [id], onDelete: Cascade)
  final List<Vibe> vibes;
  final List<Meet> meets;
  final List<Event> events;
  final List<Flock> suggestedInFlocks;
  final List<PlaceAvailability> availabilities;

  const Place({
    required this.id,
    required this.title,
    required this.isPublic,
    this.isApproved,
    this.description,
    this.preview,
    required this.locationId,
    required this.location,
    required this.vibes,
    required this.meets,
    required this.events,
    required this.suggestedInFlocks,
    required this.availabilities,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      title: json['title'],
      isPublic: json['isPublic'],
      isApproved: json['isApproved'],
      description: json['description'],
      preview: json['preview'],
      locationId: json['locationId'],
      location: json['location'],
      vibes: json['vibes'],
      meets: json['meets'],
      events: json['events'],
      suggestedInFlocks: json['suggestedInFlocks'],
      availabilities: json['availabilities'],
    );
  }
}
