class User {
  final int id;
  final String email;
  final String role;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String? photo;
  final String nickName;

  const User({
    required this.id,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    this.photo,
    required this.nickName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      role: json['role'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      photo: json['photo'],
      nickName: json['nickName'],
    );
  }
}

class Users {
  final List<User> users;
  const Users({
    required this.users,
  });
}
