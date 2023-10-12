import 'package:first_app/models/place.dart';
import 'package:first_app/models/vibe.dart';

class Location {
  final int id; //@id @default(autoincrement())
  final String name; //@unique
  final List<Vibe> vibes;
  final List<Place> places;

  const Location({
    required this.id,
    required this.name,
    required this.vibes,
    required this.places,
  });
}
