import 'package:todo/models/User.dart';
import 'package:todo/todo.dart';

class UserController extends ResourceController {
  UserController(this.context) {
    acceptedContentTypes = [ContentType.json];
  }

  final ManagedContext context;

  @Operation.post()
  Future<Response> postUser() async {
    final body = User()..read(await request.body.decode(), ignore: ["id"]);
    final query = Query<User>(context)..values = body;
    final toDo = await query.insert();
    return Response.ok(toDo);
  }
}
