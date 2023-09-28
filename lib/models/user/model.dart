class User {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photos,
    required this.vibes,
  });

  final String id;
  final String firstName;
  final String lastName;
  final List<String> photos;
  final List<String> vibes;
}
