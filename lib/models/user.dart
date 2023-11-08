import 'package:first_app/models/flock.dart';
import 'package:first_app/models/flock_users.dart';
import 'package:first_app/models/user_availability.dart';
import 'package:first_app/models/user_position.dart';
import 'package:first_app/models/vibe.dart';

enum UserRole {
  User,
  Admin,
  PlaceOwner,
  Ambassador;

  String toJson() => name;
  static UserRole fromJson(String json) => values.byName(json);
}

class User {
  final String? id; //@id @default(autoincrement())
  final String email; //@unique
  final UserRole? role; //@default(User)
  final String firstName;
  final String lastName;
  final String? password;
  final DateTime? birthdate;
  final String? nickName;
  final UserPosition? position;
  final List<UserAvailability>? availabilities;
  final List<Flock>? flocks;
  // final List<int>? vibes;
  final List<Vibe>? vibes; //@relation("UserVibes")
  final List<Vibe>? ownVibes; //@relation("OwnVibes")
  final String? photo;

  const User({
    this.id,
    required this.email,
    this.role = UserRole.User,
    required this.firstName,
    required this.lastName,
    this.password,
    this.birthdate,
    this.nickName,
    this.position,
    this.availabilities,
    this.flocks,
    this.vibes,
    this.ownVibes,
    this.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      // if (id != null) 'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      if (role != null) 'role': role!.toJson(),
      // if (vibes != null) 'vibes': vibes,
      // TODO add all
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      role: UserRole.fromJson(json['role']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      // birthdate: DateTime.parse(json['birthdate']),
      // nickName: json['nickName'],
      // position: json['position'],
      // availabilities: json['availabilities'],
      vibes: (json['vibes'] as List<dynamic>)
          .map((e) => Vibe.fromJson(e))
          .toList(),
      flocks: (json['flocks'] as List<dynamic>)
          .map((e) => Flock.fromJson(e))
          .toList(),
      // ownVibes: json['ownVibes'],
      // photo: json['photo'] ?? '',
    );
  }
}
