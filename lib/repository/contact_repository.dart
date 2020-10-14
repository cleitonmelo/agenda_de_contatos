import 'package:agenda_de_contatos/database/db.dart';
import 'package:agenda_de_contatos/migration/create_contact.dart';
import 'package:agenda_de_contatos/model/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactRepository{
  String get _tableName => Contact.getTable();

  Contact contact;
  DbConnection connection = DbConnection();

  ContactRepository({this.contact});

  Future<Contact> insert() async {
    Database db = await connection.database;
    contact.id = await db.insert(_tableName, contact.toMap());
    return contact;
  }

  Future<int> update() async {
    Database db = await connection.database;
    return await db.update(_tableName, contact.toMap(),
        where: "id = ?", whereArgs: [contact.id]);
  }

  Future<List> fetchAll() async {
    Database db = await connection.database;
    List resultList =
        await db.rawQuery("SELECT * FROM $_tableName");
    List<Contact> contacts = List();
    for (Map map in resultList) {
      contacts.add(Contact.fromMap(map));
    }
    return contacts;
  }

  Future<int> getTotal() async {
    Database db = await connection.database;
    return Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM $_tableName"));
  }

  Future<Contact> fetchById(int id) async {
    Database db = await connection.database;
    List<Map> maps = await db.query(_tableName,
        columns: ContactMigration.getAllColumns(),
        where: "id = ?",
        whereArgs: [id]);
    return maps.length > 0 ? Contact.fromMap(maps.first) : null;
  }

  Future<int> delete() async {
    Database db = await connection.database;
    return await db.delete(_tableName,
        where: "id = ?", whereArgs: [contact.id]);
  }

  Future<dynamic> save() async{
    if (contact.exists) {
      return await update();
    }
    return await insert();
  }

}
