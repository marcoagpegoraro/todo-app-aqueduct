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

    final validationMessages = userValidation(body);
    if (validationMessages.isNotEmpty) {
      return Response.ok(validationMessages);
    }

    final query = Query<User>(context);
    body.passwordHash = Utils.generateSHA256Hash(body.password);
    query.values.email = body.email;
    query.values.passwordHash = body.passwordHash;
    query.values.name = body.name;

    final user = await query.insert();
    return Response.ok(user);
  }

  List<String> userValidation(User user) {
    final errors = List<String>();
    if (user.email == null) {
      errors.add("Campo e-mail não pode ser nulo");
    }
    if (user.name == null) {
      errors.add("Campo nome não pode ser nulo");
    }
    if (user.password == null) {
      errors.add("Campo senha não pode ser nulo");
    }
    return errors;
  }
}
