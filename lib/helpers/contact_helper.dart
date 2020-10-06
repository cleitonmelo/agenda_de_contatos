import 'package:agenda_de_contatos/migration/contact.dart';
import 'package:agenda_de_contatos/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    return _db = await open();
  }

  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contacts.db");

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future close() async{
    Database dbContact = await db;
    dbContact.close();
  }

  _onCreate(Database db, int newerVersion) async {
    await db.execute(ContactMigration().initialScript);
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id =
        await dbContact.insert(ContactMigration.TABLE_NAME, contact.toMap());
    return contact;
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(ContactMigration.TABLE_NAME, contact.toMap(),
        where: "${ContactMigration.ID_COLUMN} = ?", whereArgs: [contact.id]);
  }

  Future<List> getContacts() async {
    Database dbContact = await db;
    List resultList = await dbContact
        .rawQuery("SELECT * FROM ${ContactMigration.TABLE_NAME}");

    List<Contact> contacts = List();
    for (Map map in resultList) {
      contacts.add(Contact.fromMap(map));
    }
    return contacts;
  }

  Future<int> getTotalContacts() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact
        .rawQuery("SELECT COUNT(*) FROM ${ContactMigration.TABLE_NAME}"));
  }

  Future<Contact> getContactById(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(ContactMigration.TABLE_NAME,
        columns: ContactMigration.getAllColumns(),
        where: "${ContactMigration.ID_COLUMN} = ?",
        whereArgs: [id]);
    return maps.length > 0 ? Contact.fromMap(maps.first) : null;
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(ContactMigration.TABLE_NAME,
        where: "${ContactMigration.ID_COLUMN} = ?", whereArgs: [id]);
  }
}
