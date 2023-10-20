import 'package:first_app/models/event.dart';
import 'package:first_app/models/flock.dart';
import 'package:first_app/models/location.dart';
import 'package:first_app/models/place.dart';
import 'package:first_app/models/user.dart';

enum VibeStatus {
  Approved,
  Unapproved,
}

class Vibe {
  final int? id; //@id @default(autoincrement())
  final String name; //@unique
  final VibeStatus? status; //@default(Unapproved)
  final String? icon;
  final String? background;
  final String? description;
  final int? optimalFlockSize;
  final int? creatorId;
  final User?
      creator; //@relation("OwnVibes", fields: [creatorId], references: [id], onDelete: SetNull)
  final List<Location>? locations;
  final List<Event>? events;
  final List<Place>? places;
  final List<Flock>? flocks;
  final List<User>? users; //@relation("UserVibes")

  const Vibe({
    this.id,
    required this.name,
    this.status = VibeStatus.Unapproved,
    this.icon,
    this.background,
    this.description,
    this.optimalFlockSize,
    this.creatorId,
    this.creator,
    this.locations,
    this.events,
    this.places,
    this.flocks,
    this.users,
  });

  factory Vibe.fromJson(Map<String, dynamic> json) {
    return Vibe(
      id: json['id'],
      name: json['name'],
      status: json['status'] == VibeStatus.Approved
          ? VibeStatus.Approved
          : VibeStatus.Unapproved,
      description: json['description'],
      optimalFlockSize: json['optimalFlockSize'],
      creatorId: json['creatorId'],
      creator: json['creator'],
      locations: json['locations'],
      events: json['events'],
      places: json['places'],
      users: json['users'],
    );
  }
}
