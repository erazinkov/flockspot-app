import 'package:first_app/models/user.dart';

class UserPosition {
  final int userId; //@unique
  final User
      user; //@relation(fields: [userId], references: [id], onDelete: Cascade)
  final double lat;
  final double long;

  const UserPosition({
    required this.userId,
    required this.user,
    required this.lat,
    required this.long,
  });

  factory UserPosition.fromJson(Map<String, dynamic> json) {
    return UserPosition(
      userId: json['userId'],
      user: json['user'],
      lat: json['lat'],
      long: json['long'],
    );
  }
}
