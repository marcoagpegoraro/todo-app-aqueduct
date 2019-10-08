import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration3 extends Migration {
  @override
  Future upgrade() async {
    await store.execute("""
      ALTER TABLE _user 
      RENAME COLUMN username TO name;
    """);
  }

  @override
  Future downgrade() async {
    await store.execute("""
      ALTER TABLE _user 
      RENAME COLUMN name TO username;
    """);
  }

  @override
  Future seed() async {}
}
