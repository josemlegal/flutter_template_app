import 'package:flutter_template_app/domain/user/models/user_model.dart';

abstract class UserRepository {
  Future<User> getUser(String id);
  Future<User> createNewUser(User user);

  String get userId;
}
