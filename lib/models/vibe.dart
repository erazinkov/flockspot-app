import 'package:first_app/models/event.dart';
import 'package:first_app/models/location.dart';
import 'package:first_app/models/place.dart';
import 'package:first_app/models/user.dart';

enum VibeStatus {
  Approved,
  Unapproved,
}

class Vibe {
  final int id; //@id @default(autoincrement())
  final String name; //@unique
  final VibeStatus? status; //@default(Unapproved)
  final String? description;
  final int? optimalFlockSize;
  final int? creatorId;
  final User?
      creator; //@relation("OwnVibes", fields: [creatorId], references: [id], onDelete: SetNull)
  final List<Location> locations;
  final List<Event> events;
  final List<Place> places;
  final List<User> users; //@relation("UserVibes")

  const Vibe({
    required this.id,
    required this.name,
    this.status = VibeStatus.Unapproved,
    this.description,
    this.optimalFlockSize,
    this.creatorId,
    this.creator,
    required this.locations,
    required this.events,
    required this.places,
    required this.users,
  });
}
