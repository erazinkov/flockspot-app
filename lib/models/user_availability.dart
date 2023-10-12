class UserAvailability {
  final int availabilityId; //@unique
  final Availability
      availability; //@relation(fields: [availabilityId], references: [id], onDelete: Cascade)
  final int userId;
  final User
      user; //@relation(fields: [userId], references: [id], onDelete: Cascade)

  UserAvailability({
    required this.availabilityId,
    required this.availability,
    required this.userId,
    required this.user,
  });
}
