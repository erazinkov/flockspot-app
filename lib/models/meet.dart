import 'package:first_app/models/flock.dart';
import 'package:first_app/models/place.dart';

enum MeetStatus {
  Active,
  Archived,
}

class Meet {
  final int id;
  final MeetStatus status; //@default(Active)
  final DateTime time;
  final int flockId;
  final Flock
      flock; //@relation(fields: [flockId], references: [id], onDelete: Cascade)
  final int placeId;
  final Place
      place; //@relation(fields: [placeId], references: [id], onDelete: Cascade)

  const Meet({
    required this.id,
    this.status = MeetStatus.Active,
    required this.time,
    required this.flockId,
    required this.flock,
    required this.placeId,
    required this.place,
  });

  factory Meet.fromJson(Map<String, dynamic> json) {
    return Meet(
      id: json['id'],
      status: json['status'],
      time: json['time'],
      flockId: json['flockId'],
      flock: json['flock'],
      placeId: json['placeId'],
      place: json['place'],
    );
  }
}
