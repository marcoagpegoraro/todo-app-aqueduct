import 'package:todo/models/User.dart';
import 'package:todo/todo.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class SessionController extends ResourceController {
  SessionController(this.context) {
    acceptedContentTypes = [ContentType.json];
  }

  final ManagedContext context;

  @Operation.post()
  Future<Response> login() async {
    final body = User()..read(await request.body.decode(), ignore: ["id"]);

    var bytes = utf8.encode(body.password); // data being hashed
    final passwordHash = sha256.convert(bytes);

    print(body.password);
    print(body.username);
    print(bytes);
    print(passwordHash);
    print(passwordHash.toString());

    final query = Query<User>(context)
      ..where((user) => user.username).equalTo(body.username)
      ..where((user) => user.passwordHash).equalTo(passwordHash.toString());
    final user = await query.fetchOne();
    return Response.ok(user);
  }
}
