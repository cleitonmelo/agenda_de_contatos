import 'package:agenda_de_contatos/migration/create_contact.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

class Migrate {

  // Adicionar migrations de create table
  static final initialScript = [ContactMigration.createTable];

  // Adicionar migrations de atualizações
  static final migrations = [""];

  final config = MigrationConfig(
      initializationScript: initialScript, migrationScripts: migrations);
}
