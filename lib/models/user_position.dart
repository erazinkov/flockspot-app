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
}
