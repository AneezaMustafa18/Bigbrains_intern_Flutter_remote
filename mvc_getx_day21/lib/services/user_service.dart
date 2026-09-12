import '../models/user_model.dart';

class UserService {
  UserModel? _user;

  void saveUser(UserModel user) {
    _user = user;
  }

  UserModel? getUser() {
    return _user;
  }
}