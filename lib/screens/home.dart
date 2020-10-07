import 'package:agenda_de_contatos/model/contact.dart';
import 'package:agenda_de_contatos/repository/contact_repository.dart';
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
          return cardContact(context, index);
        }
    );
  }

  Widget cardContact(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/person.png"),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: [
                        Text(contacts[index].name, style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20.0)),
                        Text(contacts[index].email, style: GoogleFonts.abel(fontSize: 18.0)),
                        Text(contacts[index].phone, style: GoogleFonts.abel(fontSize: 18.0))
                      ],
                    ),
                )
              ],
            ),
        ),
      ),
    );
  }

}
