import 'package:first_app/models/event.dart';
import 'package:first_app/models/flock_dummy.dart';

class EventFlocks {
  final DateTime time;
  final int flockId;
  final Flock
      flock; //@relation(fields: [flockId], references: [id], onDelete: Cascade)
  final int eventId;
  final Event
      event; //@relation(fields: [eventId], references: [id], onDelete: Cascade)

  //@@id([flockId, eventId])

  const EventFlocks({
    required this.time,
    required this.flockId,
    required this.flock,
    required this.eventId,
    required this.event,
  });

  factory EventFlocks.fromJson(Map<String, dynamic> json) {
    return EventFlocks(
      time: json['time'],
      flockId: json['flockId'],
      flock: json['flock'],
      eventId: json['eventId'],
      event: json['event'],
    );
  }
}
