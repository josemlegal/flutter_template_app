import 'package:flutter_template_app/domain/user/models/user_model.dart';

abstract class UserRepository {
  Future<User> getUser();
  Future<User> createNewUser(User user);
}
