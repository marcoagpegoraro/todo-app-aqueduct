import 'package:todo/todo.dart';

class User extends ManagedObject<_User> implements _User {}

class _User {
  @primaryKey
  int id;
  @Column(unique: true)
  String username;
  @Column(unique: true)
  String email;
  @Column(omitByDefault: true)
  String password;
  String passwordHash;
}
