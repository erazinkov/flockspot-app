import 'package:first_app/models/user.dart';
import 'package:first_app/models/vibe.dart';

List<User> dummyUsers = [
  const User(
    id: 0,
    email: 'test@mail.com',
    firstName: 'firstName',
    lastName: 'lastName',
    photo: 'https://via.placeholder.com/600/b0f7cc',
  ),
  const User(
    id: 1,
    email: 'test@mail.com',
    firstName: 'firstName',
    lastName: 'lastName',
    photo: 'https://via.placeholder.com/600/92c952',
  ),
  const User(
    id: 2,
    email: 'test@mail.com',
    firstName: 'firstName',
    lastName: 'lastName',
    photo: 'https://via.placeholder.com/600/771796',
  ),
  const User(
    id: 3,
    email: 'test@mail.com',
    firstName: 'firstName',
    lastName: 'lastName',
    photo: 'https://via.placeholder.com/600/24f355',
  ),
  const User(
    id: 4,
    email: 'test@mail.com',
    firstName: 'firstName',
    lastName: 'lastName',
    photo: 'https://via.placeholder.com/600/92c952',
  ),
];

List<Vibe> dummyVibes = [
  const Vibe(
    id: 0,
    name: 'hip-hop',
    status: VibeStatus.Approved,
    icon: 'string',
    background: 'https://via.placeholder.com/600/92c952',
    description:
        "Hip hop or hip-hop, also known as rap, and formerly known as disco rap, is a genre of popular music that originated in the early 1970s by African Americans.",
    optimalFlockSize: 5,
    creatorId: 0,
  ),
  const Vibe(
    id: 1,
    name: 'design',
    status: VibeStatus.Approved,
    icon: 'string',
    background: 'https://via.placeholder.com/600/771796',
    description:
        "Hip hop or hip-hop, also known as rap, and formerly known as disco rap, is a genre of popular music that originated in the early 1970s by African Americans.",
    optimalFlockSize: 5,
    creatorId: 0,
  ),
  const Vibe(
    id: 2,
    name: 'digital',
    status: VibeStatus.Approved,
    icon: 'string',
    background: 'https://via.placeholder.com/600/d32776',
    description:
        "Hip hop or hip-hop, also known as rap, and formerly known as disco rap, is a genre of popular music that originated in the early 1970s by African Americans.",
    optimalFlockSize: 5,
    creatorId: 0,
  ),
  const Vibe(
    id: 3,
    name: 'startup',
    status: VibeStatus.Approved,
    icon: 'string',
    background: 'https://via.placeholder.com/600/92c952',
    description:
        "Hip hop or hip-hop, also known as rap, and formerly known as disco rap, is a genre of popular music that originated in the early 1970s by African Americans.",
    optimalFlockSize: 5,
    creatorId: 0,
  ),
  const Vibe(
    id: 4,
    name: 'nofly',
    status: VibeStatus.Approved,
    icon: 'string',
    background: 'https://via.placeholder.com/600/f66b97',
    description:
        "Hip hop or hip-hop, also known as rap, and formerly known as disco rap, is a genre of popular music that originated in the early 1970s by African Americans.",
    optimalFlockSize: 5,
    creatorId: 0,
  ),
  const Vibe(
    id: 5,
    name: 'book',
    status: VibeStatus.Approved,
    icon: 'string',
    background: 'https://via.placeholder.com/600/56a8c2',
    description:
        "Hip hop or hip-hop, also known as rap, and formerly known as disco rap, is a genre of popular music that originated in the early 1970s by African Americans.",
    optimalFlockSize: 5,
    creatorId: 0,
  ),
];
