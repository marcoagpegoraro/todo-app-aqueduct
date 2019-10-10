import 'package:todo/models/User.dart';
import 'package:todo/todo.dart';

class ToDo extends ManagedObject<_ToDo> implements _ToDo {}

class _ToDo {
  @primaryKey
  int id;
  String name;
  bool done;

  @Relate(#toDo)
  User user;
}
