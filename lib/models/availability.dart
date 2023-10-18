import 'package:first_app/models/flock_dummy.dart';
import 'package:first_app/models/place_availability.dart';
import 'package:first_app/models/user_availability.dart';
import 'package:intl/intl.dart';

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

  String get formattedDayOfWeek {
    String dayOfWeek = 'unknown';
    switch (this.dayOfWeek) {
      case DayOfWeek.Sun:
        dayOfWeek = 'sunday';
      case DayOfWeek.Mon:
        dayOfWeek = 'monday';
      case DayOfWeek.Tue:
        dayOfWeek = 'tuesday';
      case DayOfWeek.Wed:
        dayOfWeek = 'wednesday';
      case DayOfWeek.Thu:
        dayOfWeek = 'thursday';
      case DayOfWeek.Fri:
        dayOfWeek = 'friday';
      case DayOfWeek.Sat:
        dayOfWeek = 'saturday';
      default:
        dayOfWeek = 'unknown';
    }
    return dayOfWeek[0].toUpperCase() + dayOfWeek.substring(1).toLowerCase();
  }

  String get formattedStartAt {
    return DateFormat('hh:mm').format(startAt);
  }

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      id: json['id'],
      startAt: json['startAt'],
      endAt: json['endAt'],
      dayOfWeek: json['dayOfWeek'],
      suggestedInFlocks: json['suggestedInFlocks'],
      userAvailabilities: json['userAvailabilities'],
      placeAvailabilities: json['placeAvailabilities'],
    );
  }
}
