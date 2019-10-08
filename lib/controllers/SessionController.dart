import 'package:todo/models/User.dart';
import 'package:todo/todo.dart';
import 'package:todo/utils/Utils.dart';

class SessionController extends ResourceController {
  SessionController(this.context) {
    acceptedContentTypes = [ContentType.json];
  }

  final ManagedContext context;

  @Operation.post()
  Future<Response> login() async {
    final body = User()..read(await request.body.decode(), ignore: ["id"]);

    final passwordHash = Utils.generateSHA256Hash(body.password);

    final query = Query<User>(context)
      ..where((user) => user.email).like(body.email)
      ..where((user) => user.passwordHash).like(passwordHash.toString());
    final user = await query.fetchOne();

    if (user == null) {
      return Response.ok("Usuário não encontrado");
    }

    return Response.ok(user);
  }
}
