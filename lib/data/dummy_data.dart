// import 'package:first_app/models/availability.dart';
// import 'package:first_app/models/flock.dart';
// import 'package:first_app/models/flock_users.dart';
// import 'package:first_app/models/location.dart';
// import 'package:first_app/models/meet.dart';
// import 'package:first_app/models/place.dart';
// import 'package:first_app/models/user.dart';
// import 'package:first_app/models/vibe.dart';

// List<Vibe> dummyOwnVibes = [
//   Vibe(
//     id: 0,
//     name: 'Surfing',
//     locations: [],
//     events: [],
//     places: [],
//     users: [...dummyUsers],
//   ),
//   Vibe(
//     id: 1,
//     name: 'Singing',
//     locations: [],
//     events: [],
//     places: [],
//     users: [...dummyUsers],
//   ),
// ];

// List<User> dummyUsers = [
//   User(
//     id: 0,
//     email: 'test@email.com',
//     firstName: 'Elena',
//     lastName: 'Alexandrova',
//     dateOfBirth: DateTime(2017, 9, 7, 17, 30),
//     availabilities: [],
//     flocks: [],
//     vibes: dummyVibes,
//     ownVibes: [],
//     photo:
//         'https://image.dummyjson.com/150,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/282828',
//   ),
//   User(
//     id: 1,
//     email: 'test@email.com',
//     firstName: 'firstNameUser1',
//     lastName: 'lastNameUser1',
//     dateOfBirth: DateTime(2017, 9, 7, 17, 30),
//     availabilities: [],
//     flocks: [],
//     vibes: [],
//     ownVibes: [],
//     photo:
//         'https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/282828',
//   ),
// ];

// // const dummyFlock = Flock(
// //   id: 1,
// //   name: 'FlockName1',
// //   flockSize: 1,
// //   meets: [],
// //   suggestedPlaces: [],
// //   users: [],
// // );

// var dummyLocation = Location(name: 'Portugal');

// final dummyPlace = Place(
//   id: 0,
//   title: 'lisbon',
//   isPublic: true,
//   locationId: 0,
//   location: dummyLocation,
//   vibes: dummyVibes,
//   meets: [],
//   events: [],
//   suggestedInFlocks: [],
//   availabilities: [],
// );

// final dummyMeets = [
//   Meet(
//     id: 0,
//     time: DateTime(2017, 9, 7, 17, 30),
//     flockId: 0,
//     flock: dummyFlock,
//     placeId: 0,
//     place: dummyPlace,
//   ),
//   Meet(
//     id: 1,
//     time: DateTime(2017, 9, 7, 17, 30),
//     flockId: 0,
//     flock: dummyFlock,
//     placeId: 0,
//     place: dummyPlace,
//   ),
//   Meet(
//     id: 2,
//     time: DateTime(2017, 9, 7, 17, 30),
//     flockId: 0,
//     flock: dummyFlock,
//     placeId: 0,
//     place: dummyPlace,
//   ),
// ];

// List<FlockUsers> dummyFlockUsers = [
//   FlockUsers(
//     userId: 0,
//     user: dummyUsers[0],
//     flockId: 0,
//     flock: dummyFlock,
//   ),
//   FlockUsers(
//     userId: 1,
//     user: dummyUsers[1],
//     flockId: 0,
//     flock: dummyFlock,
//   ),
//   FlockUsers(
//     userId: 2,
//     user: dummyUsers[0],
//     flockId: 0,
//     flock: dummyFlock,
//   ),
//   FlockUsers(
//     userId: 2,
//     user: dummyUsers[0],
//     flockId: 0,
//     flock: dummyFlock,
//   ),
//   FlockUsers(
//     userId: 2,
//     user: dummyUsers[0],
//     flockId: 0,
//     flock: dummyFlock,
//   ),
//   FlockUsers(
//     userId: 2,
//     user: dummyUsers[0],
//     flockId: 0,
//     flock: dummyFlock,
//   ),
// ];

// List<Availability> dummySuggestedTimes = [
//   Availability(
//       id: 0,
//       startAt: DateTime.now(),
//       endAt: DateTime.now(),
//       dayOfWeek: DayOfWeek.Mon,
//       suggestedInFlocks: [],
//       userAvailabilities: [],
//       placeAvailabilities: []),
// ];

// List<Flock> dummyFlocks = [
//   Flock(
//     id: 0,
//     name: 'FlockName0',
//     flockSize: 1,
//     meets: dummyMeets,
//     suggestedPlaces: [],
//     users: dummyUsers,
//   ),
//   Flock(
//     id: 1,
//     name: 'FlockName1',
//     flockSize: 1,
//     meets: dummyMeets,
//     suggestedPlaces: [],
//     users: dummyUsers,
//   ),
//   Flock(
//     id: 2,
//     name: 'FlockName2',
//     flockSize: 1,
//     meets: dummyMeets,
//     suggestedPlaces: [],
//     users: dummyUsers,
//     // events: [],
//     // suggestedTimes: [],
//   )
// ];

// List<Vibe> dummyVibes = [
//   const Vibe(
//     id: 0,
//     name: 'digital',
//     locations: [],
//     events: [],
//     places: [],
//     users: [],
//   ),
//   const Vibe(
//     id: 1,
//     name: 'artists',
//     locations: [],
//     events: [],
//     places: [],
//     users: [],
//   ),
//   const Vibe(
//     id: 2,
//     name: 'spanish',
//     locations: [],
//     events: [],
//     places: [],
//     users: [],
//   ),
//   const Vibe(
//     id: 0,
//     name: 'hip-hop',
//     locations: [],
//     events: [],
//     places: [],
//     users: [],
//   ),
//   const Vibe(
//     id: 1,
//     name: 'yoga',
//     locations: [],
//     events: [],
//     places: [],
//     users: [],
//   ),
//   const Vibe(
//     id: 2,
//     name: 'dancing',
//     locations: [],
//     events: [],
//     places: [],
//     users: [],
//   ),
// ];
