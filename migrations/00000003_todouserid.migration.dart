import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration4 extends Migration {
  @override
  Future upgrade() async {
    database.addColumn(
        "_ToDo",
        SchemaColumn.relationship("user", ManagedPropertyType.bigInteger,
            relatedTableName: "_User",
            relatedColumnName: "id",
            rule: DeleteRule.nullify,
            isNullable: true,
            isUnique: false));
  }

  @override
  Future downgrade() async {
    database.deleteColumn("_ToDo", "user");
  }

  @override
  Future seed() async {}
}
