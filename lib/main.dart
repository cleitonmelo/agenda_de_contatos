import 'package:agenda_de_contatos/screens/home.dart';
import 'package:agenda_de_contatos/screens/loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Agenda de Contatos",
    home: Loading(),
    debugShowCheckedModeBanner: false,
  ));
}
