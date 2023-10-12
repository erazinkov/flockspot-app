import 'package:first_app/models/availability.dart';
import 'package:first_app/models/user.dart';

class UserAvailability {
  final int availabilityId; //@unique
  final Availability
      availability; //@relation(fields: [availabilityId], references: [id], onDelete: Cascade)
  final int userId;
  final User
      user; //@relation(fields: [userId], references: [id], onDelete: Cascade)

  const UserAvailability({
    required this.availabilityId,
    required this.availability,
    required this.userId,
    required this.user,
  });

  factory UserAvailability.fromJson(Map<String, dynamic> json) {
    return UserAvailability(
      availabilityId: json['availabilityId'],
      availability: json['availability'],
      userId: json['userId'],
      user: json['user'],
    );
  }
}
