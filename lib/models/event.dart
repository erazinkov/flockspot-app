import 'package:first_app/models/event_flocks.dart';
import 'package:first_app/models/place.dart';
import 'package:first_app/models/vibe.dart';

class Event {
  final int id; //@id @default(autoincrement())
  final String title;
  final DateTime startAt;
  final DateTime endAt;
  final String? description;
  final String? preview;
  final int placeId;
  final Place
      place; //@relation(fields: [placeId], references: [id], onDelete: Cascade)
  final List<Vibe> vibes;
  final List<EventFlocks> flocks;

  const Event({
    required this.id,
    required this.title,
    required this.startAt,
    required this.endAt,
    this.description,
    this.preview,
    required this.placeId,
    required this.place,
    required this.vibes,
    required this.flocks,
  });
}
