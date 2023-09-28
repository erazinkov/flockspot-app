import 'package:first_app/models/user/model.dart';

List<String> photos = [
  'assets/images/photo-0.jpeg',
  'assets/images/photo-1.jpeg',
  'assets/images/photo-2.jpeg',
  'assets/images/photo-3.jpeg',
  'assets/images/photo-4.jpeg',
  'assets/images/photo-5.jpeg',
  'assets/images/photo-6.jpeg',
  'assets/images/photo-7.jpeg',
  'assets/images/photo-8.jpeg',
  'assets/images/photo-9.jpeg',
];

List<String> vibes = [
  'cooking',
  'writing',
  'dance',
  'drawing',
  'fishing',
  'golf',
  'gardening',
  'chess',
];

var dummy = User(
  id: '0',
  firstName: 'Joseph',
  lastName: 'Gonzalez',
  photos: photos,
  vibes: vibes,
);
