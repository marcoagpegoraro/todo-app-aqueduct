import 'package:todo/models/ToDo.dart';
import 'package:todo/todo.dart';

class ToDoController extends ResourceController {
 
  ToDoController(){
    acceptedContentTypes = [ContentType.json];
  }
  
  final List<ToDo> toDos = [
    ToDo()..id = 1 ..name = 'trabaia1'..done = false,
    ToDo()..id = 2 ..name = 'trabaia2'..done = false,
    ToDo()..id = 3 ..name = 'trabaia3'..done = false,
    ToDo()..id = 4 ..name = 'trabaia4'..done = false,
    ToDo()..id = 5 ..name = 'trabaia5'..done = false,
    ToDo()..id = 6 ..name = 'trabaia6'..done = false,
  ];

  @Operation.get()
  Future<Response> getAllToDos() async {
    return Response.ok(toDos);
  }

  @Operation.get('id')
  Future<Response> getToDoByID() async {
    final id = int.parse(request.path.variables['id']);
    final toDo = toDos.firstWhere((todo) => todo.id == id, orElse: () => null);
    if (toDo == null) {
      return Response.notFound();
    }

    return Response.ok(toDo);
  }

  @Operation.post()
  Future<Response> postToDo(@Bind.body() ToDo toDo) async {
    toDos.add(toDo);
    return Response.ok(toDos);
  }

  
  @Operation.put()
  Future<Response> putToDo(@Bind.body() ToDo toDo) async {
    toDos.removeAt(toDos.indexWhere((r)=> r.id == toDo.id));
    toDos.add(toDo);
    return Response.ok(toDos);
  }
  
  @Operation.delete('id')
  Future<Response> deleteToDoByID() async {
    final id = int.parse(request.path.variables['id']);
    toDos.removeAt(toDos.indexWhere((r)=> r.id == id));
    return Response.ok(toDos);
  }
}