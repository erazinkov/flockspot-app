import 'package:first_app/models/flock.dart';
import 'package:first_app/models/user.dart';

enum FlockUserStatus {
  Pending,
  Active,
  Left,
}

class FlockUsers {
  final FlockUserStatus status; //@default(Pending)
  final int userId;
  final User
      user; //@relation(fields: [userId], references: [id], onDelete: Cascade)
  final int flockId;
  final Flock?
      flock; //@relation(fields: [flockId], references: [id], onDelete: Cascade)

  //@@id([userId, flockId])

  const FlockUsers({
    this.status = FlockUserStatus.Pending,
    required this.userId,
    required this.user,
    required this.flockId,
    this.flock,
  });

  factory FlockUsers.fromJson(Map<String, dynamic> json) {
    return FlockUsers(
      status: json['status'],
      userId: json['userId'],
      user: json['user'],
      flockId: json['flockId'],
      flock: json['flock'],
    );
  }
}
