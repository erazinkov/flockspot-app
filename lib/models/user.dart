class User {
  final int id;
  final String firstName;
  final String lastName;
  final List<String> photos;
  final List<String> vibes;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.vibes,
    required this.photos,
  });
}
