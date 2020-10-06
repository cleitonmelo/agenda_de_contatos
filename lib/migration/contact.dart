class ContactMigration{
  static const TABLE_NAME = "contacts";

  static const ID_COLUMN = "id";
  static const NAME_COLUMN = "name";
  static const EMAIL_COLUMN = "email";
  static const PHONE_COLUMN = "phoned";
  static const IMAGE_COLUMN = "src_image";

  static getAllColumns(){
    return [
      ID_COLUMN, NAME_COLUMN, EMAIL_COLUMN, PHONE_COLUMN, IMAGE_COLUMN
    ];
  }

  final String initialScript = '''
    CREATE TABLE $TABLE_NAME (
      $ID_COLUMN INTEGER PRIMARY KEY AUTOINCREMENT,
      $NAME_COLUMN TEXT not null,
      $EMAIL_COLUMN TEXT not null,
      $PHONE_COLUMN TEXT,
      $IMAGE_COLUMN TEXT
    )
    ''';
}