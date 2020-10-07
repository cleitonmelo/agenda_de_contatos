import 'package:agenda_de_contatos/model/contact.dart';
import 'package:agenda_de_contatos/repository/contact_repository.dart';
import 'package:agenda_de_contatos/screens/card/card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();

    ContactRepository().fetchAll().then((values) => contacts = values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda de Contatos",
            style: GoogleFonts.abel(color: Colors.white, fontSize: 30.0)),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add_circle_outline,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey,
      ),
      body: listView(),
    );
  }

  Widget listView(){
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        itemBuilder: (context, index ) {
          return cardContact(context, contacts[index]);
        }
    );
  }



}
