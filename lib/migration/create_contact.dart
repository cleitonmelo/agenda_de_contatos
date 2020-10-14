import 'package:agenda_de_contatos/model/contact.dart';

class ContactMigration{

  static getAllColumns(){
    return Contact.getAllColumns();
  }

  static final createTable = '''
    CREATE TABLE ${Contact.getTable()} (
      ${Contact.getColumnId()} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Contact.getColumnName()} TEXT not null,
      ${Contact.getColumnEmail()} TEXT not null,
      ${Contact.getColumnPhone()} TEXT,
      ${Contact.getColumnImage()} TEXT
    )
    ''';
}