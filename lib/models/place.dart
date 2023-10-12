import 'package:first_app/models/event.dart';
import 'package:first_app/models/flock.dart';
import 'package:first_app/models/meet.dart';
import 'package:first_app/models/place_availability.dart';

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
}
