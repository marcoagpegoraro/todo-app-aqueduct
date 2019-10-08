import 'package:todo/models/User.dart';
import 'package:todo/todo.dart';
import 'package:todo/utils/Utils.dart';

class UserController extends ResourceController {
  UserController(this.context) {
    acceptedContentTypes = [ContentType.json];
  }

  final ManagedContext context;

  @Operation.post()
  Future<Response> postUser() async {
    final body = User()..read(await request.body.decode(), ignore: ["id"]);
    body.passwordHash = Utils.generateSHA256Hash(body.password);
    final query = Query<User>(context);
    query.values.email = body.email;
    query.values.passwordHash = body.passwordHash;
    query.values.username = body.username;
    final toDo = await query.insert();
    return Response.ok(toDo);
  }
}
