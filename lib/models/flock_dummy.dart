import 'package:first_app/models/event_flocks.dart';
import 'package:first_app/models/flock_users.dart';
import 'package:first_app/models/meet.dart';
import 'package:first_app/models/place.dart';

class Flock {
  final int id; //@id @default(autoincrement())
  final int flockSize;
  final List<Meet> meets;
  final List<Place> suggestedPlaces;
  final List<FlockUsers> users;
  final List<EventFlocks> events;
  final List<Availability> suggestedTimes;

  const Flock({
    required this.id,
    required this.flockSize,
    required this.meets,
    required this.suggestedPlaces,
    required this.users,
    required this.events,
    required this.suggestedTimes,
  });

  factory Flock.fromJson(Map<String, dynamic> json) {
    return Flock(
      id: json['id'],
      flockSize: json['flockSize'],
      meets: json['meets'],
      suggestedPlaces: json['suggestedPlaces'],
      users: json['users'],
      events: json['events'],
      suggestedTimes: json['suggestedTimes'],
    );
  }
}
