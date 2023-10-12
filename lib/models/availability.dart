import 'package:first_app/models/flock_dummy.dart';
import 'package:first_app/models/place_availability.dart';
import 'package:first_app/models/user_availability.dart';

enum DayOfWeek {
  Sun,
  Mon,
  Tue,
  Wed,
  Thu,
  Fri,
  Sat,
}

class Availability {
  final int id; //@id @default(autoincrement())
  final DateTime startAt;
  final DateTime endAt;
  final DayOfWeek dayOfWeek;
  final List<Flock> suggestedInFlocks;
  final List<UserAvailability> userAvailabilities;
  final List<PlaceAvailability> placeAvailabilities;

  const Availability({
    required this.id,
    required this.startAt,
    required this.endAt,
    required this.dayOfWeek,
    required this.suggestedInFlocks,
    required this.userAvailabilities,
    required this.placeAvailabilities,
  });
}
