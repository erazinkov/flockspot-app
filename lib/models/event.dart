import 'package:first_app/models/event_flocks.dart';
import 'package:first_app/models/place.dart';
import 'package:first_app/models/vibe.dart';

class Event {
  final int? id; //@id @default(autoincrement())
  final String title;
  final DateTime startAt;
  final DateTime endAt;
  final String? address;
  final String? description;
  final String? preview;
  final int? placeId;
  final Place?
      place; //@relation(fields: [placeId], references: [id], onDelete: Cascade)
  final List<Vibe>? vibes;
  final List<EventFlocks>? flocks;

  const Event({
    this.id,
    required this.title,
    required this.startAt,
    required this.endAt,
    this.address,
    this.description,
    this.preview,
    this.placeId,
    this.place,
    this.vibes,
    this.flocks,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      startAt: DateTime.parse(json['startAt']),
      endAt: DateTime.parse(json['endAt']),
      address: json['address'],
      description: json['description'],
      preview: json['preview'],
      placeId: json['placeId'],
      place: json['place'],
      vibes: json['vibes'],
      flocks: json['flocks'],
    );
  }
}
