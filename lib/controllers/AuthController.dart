import 'package:todo/todo.dart';

class AuthController extends ResourceController {
  AuthController(this.context) {
    acceptedContentTypes = [ContentType.json];
  }

  final ManagedContext context;
}
