class Flock {
  final int id;
  final int flockSize;

  const Flock({
    required this.id,
    required this.flockSize,
  });

  factory Flock.fromJson(Map<String, dynamic> json) {
    return Flock(
      id: json['id'],
      flockSize: json['flockSize'],
    );
  }
}
