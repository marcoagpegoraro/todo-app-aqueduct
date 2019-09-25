import 'package:todo/controllers/ToDoController.dart';

import 'todo.dart';

class TodoChannel extends ApplicationChannel {

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/todo/[:id]").link(() => ToDoController());

    router
      .route("/example")
      .linkFunction((request) async {
        return Response.ok({"key": "value"});
      });

    return router;
  }
}