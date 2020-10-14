import 'package:agenda_de_contatos/migration/create_contact.dart';

enum OrderOptions {
  orderAsc,
  orderDesc,
}

class Contact {
  static String getTable() => "contacts";

  static String getColumnId() => "id";

  static String getColumnName() => "name";

  static String getColumnEmail() => "email";

  static String getColumnPhone() => "phoned";

  static String getColumnImage() => "src_image";

  static getAllColumns() {
    return [getColumnId,
      getColumnName,
      getColumnEmail,
      getColumnPhone,
      getColumnImage
    ];
  }

  int id;
  String name;
  String email;
  String phone;
  String image;
  String get tableName => getTable();

  Contact();

  Contact.fromMap(Map map) {
    id = map[getColumnId()];
    name = map[getColumnName()];
    email = map[getColumnEmail()];
    phone = map[getColumnPhone()];
    image = map[getColumnImage()];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      getColumnName(): name,
      getColumnEmail(): email,
      getColumnPhone() : phone,
      getColumnImage(): image
    };
    if (exists) {
      map[getColumnId()] = id;
    }
    return map;
  }

  bool get exists {
    return id != null && id > 0;
  }

  @override
  String toString() {
    return "Contact{ id : $id , name: $name, email: $email, phone: $phone, img: $image }";
  }
}
