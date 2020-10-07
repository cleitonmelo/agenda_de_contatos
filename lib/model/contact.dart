import 'package:agenda_de_contatos/migration/create_contact.dart';

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String image;

    Contact();

  Contact.fromMap(Map map) {
    id = map[ContactMigration.ID_COLUMN];
    name = map[ContactMigration.NAME_COLUMN];
    email = map[ContactMigration.EMAIL_COLUMN];
    phone = map[ContactMigration.PHONE_COLUMN];
    image = map[ContactMigration.IMAGE_COLUMN];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      ContactMigration.ID_COLUMN : id != null ? id : null,
      ContactMigration.NAME_COLUMN : name,
      ContactMigration.EMAIL_COLUMN : email,
      ContactMigration.PHONE_COLUMN : phone,
      ContactMigration.IMAGE_COLUMN : image
    };
    return map;
  }

  @override
  String toString() {
    return "Contact{ id : $id , name: $name, email: $email, phone: $phone, img: $image }";
  }
}
