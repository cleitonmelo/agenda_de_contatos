import 'package:agenda_de_contatos/model/contact.dart';
import 'package:agenda_de_contatos/screens/pages/contact.dart';
import 'package:flutter/material.dart';

class PageHelper{
  BuildContext context;

  PageHelper(this.context);

  void showPageContact({Contact contact}) {
    Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => ContactPage(contact: contact),
        ));
  }
}

