import 'package:todo/controllers/ToDoController.dart';

import 'todo.dart';

class TodoChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        "postgres", "postgres", "localhost", 5432, "todo_aqueduct");

    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/todo/[:id]").link(() => ToDoController(context));

    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    return router;
  }
}
