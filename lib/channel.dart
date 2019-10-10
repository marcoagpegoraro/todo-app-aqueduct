import 'package:todo/controllers/SessionController.dart';
import 'package:todo/controllers/ToDoController.dart';
import 'package:todo/controllers/UserController.dart';
import 'package:todo/middlewares/JwtMiddleware.dart';

import 'todo.dart';

class TodoChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        "postgres", "docker", "localhost", 5432, "todo_aqueduct");

    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
        .route("/todo/[:id]")
        .link(() => JwtMiddleware(context))
        .link(() => ToDoController(context));
    router.route("/user/[:id]").link(() => UserController(context));
    router.route("/session/[:id]").link(() => SessionController(context));

    return router;
  }
}
