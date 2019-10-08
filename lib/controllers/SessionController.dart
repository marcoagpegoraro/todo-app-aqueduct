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

    print(body.password);
    print(body.username);
    print(passwordHash);
    print(passwordHash.toString());

    final query = Query<User>(context)
      ..where((user) => user.username).equalTo(body.username)
      ..where((user) => user.passwordHash).equalTo(passwordHash.toString());
    final user = await query.fetchOne();

    if(user == null){
      return Response.notFound();
    }

    return Response.ok(user);
  }
}
