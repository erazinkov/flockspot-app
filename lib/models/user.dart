import 'package:first_app/models/flock_users.dart';
import 'package:first_app/models/user_availability.dart';
import 'package:first_app/models/user_position.dart';
import 'package:first_app/models/vibe.dart';

enum UserRole {
  User,
  Admin,
  PlaceOwner,
  Ambassador,
}

class User {
  final int? id; //@id @default(autoincrement())
  final String email; //@unique
  final UserRole? role; //@default(User)
  final String firstName;
  final String lastName;
  final DateTime birthdate;
  final String? nickName;
  final UserPosition? position;
  final List<UserAvailability>? availabilities;
  final List<FlockUsers>? flocks;
  final List<Vibe>? vibes; //@relation("UserVibes")
  final List<Vibe>? ownVibes; //@relation("OwnVibes")
  final String? photo;

  const User({
    this.id,
    required this.email,
    this.role = UserRole.User,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    this.nickName,
    this.position,
    this.availabilities,
    this.flocks,
    this.vibes,
    this.ownVibes,
    this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      // role: json['role'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthdate: DateTime.parse(json['birthdate']),
      // nickName: json['nickName'],
      // position: json['position'],
      // availabilities: json['availabilities'],
      // flocks: json['flocks'],
      // vibes: json['vibes'],
      // ownVibes: json['ownVibes'],
      photo: json['photo'] ?? '',
    );
  }
}
