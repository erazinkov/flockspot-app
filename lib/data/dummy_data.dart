import 'package:first_app/models/flock_dummy.dart';
import 'package:first_app/models/flock_users.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/models/vibe.dart';

List<Vibe> dummyOwnVibes = [
  Vibe(
    id: 0,
    name: 'Surfing',
    locations: [],
    events: [],
    places: [],
    users: [...dummyUsers],
  ),
  Vibe(
    id: 1,
    name: 'Singing',
    locations: [],
    events: [],
    places: [],
    users: [...dummyUsers],
  ),
];

List<User> dummyUsers = [
  User(
    id: 0,
    email: 'test@email.com',
    firstName: 'firstNameUser0',
    lastName: 'lastNameUser0',
    dateOfBirth: DateTime(2017, 9, 7, 17, 30),
    availabilities: [],
    flocks: [],
    vibes: [],
    ownVibes: [],
    photo:
        'https://image.dummyjson.com/150,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/282828',
  ),
  User(
    id: 1,
    email: 'test@email.com',
    firstName: 'firstNameUser1',
    lastName: 'lastNameUser1',
    dateOfBirth: DateTime(2017, 9, 7, 17, 30),
    availabilities: [],
    flocks: [],
    vibes: [],
    ownVibes: [],
    photo:
        'https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/008080/ffffff?text=Hello+Peter,https://image.dummyjson.com/400x200/282828',
  ),
];

const dummyFlocks1 = Flock(
  id: 1,
  flockSize: 1,
  meets: [],
  suggestedPlaces: [],
  users: [],
  events: [],
  suggestedTimes: [],
);

List<FlockUsers> dummyFlockUsers = [
  FlockUsers(
    userId: 0,
    user: dummyUsers[0],
    flockId: 0,
    flock: dummyFlocks1,
  ),
  FlockUsers(
    userId: 1,
    user: dummyUsers[1],
    flockId: 0,
    flock: dummyFlocks1,
  ),
  FlockUsers(
    userId: 2,
    user: dummyUsers[0],
    flockId: 0,
    flock: dummyFlocks1,
  ),
];

List<Flock> dummyFlocks = [
  Flock(
    id: 0,
    flockSize: 1,
    meets: [],
    suggestedPlaces: [],
    users: dummyFlockUsers,
    events: [],
    suggestedTimes: [],
  ),
  Flock(
    id: 1,
    flockSize: 1,
    meets: [],
    suggestedPlaces: [],
    users: dummyFlockUsers,
    events: [],
    suggestedTimes: [],
  ),
  Flock(
    id: 2,
    flockSize: 1,
    meets: [],
    suggestedPlaces: [],
    users: dummyFlockUsers,
    events: [],
    suggestedTimes: [],
  )
];
