import 'package:agenda_de_contatos/model/contact.dart';

class ContactHelper{
  Contact contact;

  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;

  ContactHelper.internal();

}
