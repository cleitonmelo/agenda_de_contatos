import 'package:agenda_de_contatos/migration/create_contact.dart';
import 'package:agenda_de_contatos/model/contact.dart';
import 'package:agenda_de_contatos/service/db.dart';
import 'package:sqflite/sqflite.dart';

class ContactRepository{
  Contact contact;
  DbConnection connection = DbConnection();

  ContactRepository({this.contact});

  Future<Contact> save() async {
    Database db = await connection.database;
    contact.id = await db.insert(ContactMigration.TABLE_NAME, contact.toMap());
    return contact;
  }

  Future<int> update() async {
    Database db = await connection.database;
    return await db.update(ContactMigration.TABLE_NAME, contact.toMap(),
        where: "${ContactMigration.ID_COLUMN} = ?", whereArgs: [contact.id]);
  }

  Future<List> fetchAll() async {
    Database db = await connection.database;
    List resultList =
        await db.rawQuery("SELECT * FROM ${ContactMigration.TABLE_NAME}");

    List<Contact> contacts = List();
    for (Map map in resultList) {
      contacts.add(Contact.fromMap(map));
    }
    return contacts;
  }

  Future<int> getTotal() async {
    Database db = await connection.database;
    return Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM ${ContactMigration.TABLE_NAME}"));
  }

  Future<Contact> fetchById(int id) async {
    Database db = await connection.database;
    List<Map> maps = await db.query(ContactMigration.TABLE_NAME,
        columns: ContactMigration.getAllColumns(),
        where: "${ContactMigration.ID_COLUMN} = ?",
        whereArgs: [id]);
    return maps.length > 0 ? Contact.fromMap(maps.first) : null;
  }

  Future<int> delete(int id) async {
    Database db = await connection.database;
    return await db.delete(ContactMigration.TABLE_NAME,
        where: "${ContactMigration.ID_COLUMN} = ?", whereArgs: [id]);
  }
}
