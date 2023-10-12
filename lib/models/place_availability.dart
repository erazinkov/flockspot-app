import 'package:first_app/models/availability.dart';
import 'package:first_app/models/place.dart';

class PlaceAvailability {
  final int availabilityId; //@unique
  final Availability
      availability; //@relation(fields: [availabilityId], references: [id], onDelete: Cascade)
  final int placeId;
  final Place
      place; //@relation(fields: [placeId], references: [id], onDelete: Cascade)

  const PlaceAvailability({
    required this.availabilityId,
    required this.availability,
    required this.placeId,
    required this.place,
  });

  factory PlaceAvailability.fromJson(Map<String, dynamic> json) {
    return PlaceAvailability(
      availabilityId: json['availabilityId'],
      availability: json['availability'],
      placeId: json['placeId'],
      place: json['place'],
    );
  }
}
