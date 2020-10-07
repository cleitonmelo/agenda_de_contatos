import 'package:agenda_de_contatos/migration/migrate.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

class DbConnection {
  static final DbConnection _instance = DbConnection.internal();
  factory DbConnection() => _instance;

  DbConnection.internal();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await open();
    return _database;
  }

  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contacts.db");
    return await openDatabaseWithMigration(path, Migrate().config);
  }

  Future close() async {
    Database database = await this.database;
    database.close();
  }
}
