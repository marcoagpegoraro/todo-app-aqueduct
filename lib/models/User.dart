import 'package:todo/todo.dart';

class User extends ManagedObject<_User> implements _User {}

class _User {
  @primaryKey
  int id;
  String username;
  String email;
  String passwordHash;
}
