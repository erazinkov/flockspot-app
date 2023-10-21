import 'package:first_app/models/event.dart';
import 'package:first_app/models/flock.dart';
import 'package:first_app/models/place.dart';

enum MeetStatus {
  Active,
  Archived,
}

class Meet {
  final int? id;
  final MeetStatus? status; //@default(Active)
  final DateTime time;
  final int flockId;
  final String? address;
  final int? placeId;
  final int? eventId;
  final Event? event;
  final Flock?
      flock; //@relation(fields: [flockId], references: [id], onDelete: Cascade)
  final Place?
      place; //@relation(fields: [placeId], references: [id], onDelete: Cascade)

  const Meet({
    this.id,
    this.status = MeetStatus.Active,
    required this.time,
    required this.flockId,
    this.address,
    this.placeId,
    this.eventId,
    this.event,
    this.flock,
    this.place,
  });

  factory Meet.fromJson(Map<String, dynamic> json) {
    return Meet(
      id: json['id'],
      status: json['status'] == MeetStatus.Active
          ? MeetStatus.Active
          : MeetStatus.Archived,
      time: DateTime.parse(json['time']),
      flockId: json['flockId'],
      address: json['address'],
      event: Event.fromJson(json['event']),
      // flock: json['flock'],
      // placeId: json['placeId'],
      // place: json['place'],
    );
  }
}
