import 'package:first_app/models/user_credentials.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCredentialsNotifier extends StateNotifier<UserCredentials> {
  UserCredentialsNotifier() : super(UserCredentials());

  void set(UserCredentials userCredentials) {
    state = userCredentials;
  }
}

final userCredentialsProvider =
    StateNotifierProvider<UserCredentialsNotifier, UserCredentials>(
        (ref) => UserCredentialsNotifier());
