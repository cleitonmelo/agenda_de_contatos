import 'package:agenda_de_contatos/enum/ContactOrder.dart';
import 'package:agenda_de_contatos/model/contact.dart';
import 'package:agenda_de_contatos/repository/contact_repository.dart';
import 'package:agenda_de_contatos/screens/card/card.dart';
import 'package:agenda_de_contatos/screens/pages/contact.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text("Contatos",
            style: GoogleFonts.abel(color: Colors.white, fontSize: 30.0)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordernar de A-Z"),
                value: OrderOptions.orderAsc,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordernar de Z-A"),
                value: OrderOptions.orderDesc,
              )
            ],
            onSelected: _orderList,
          )
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: showPageContact,
        child: Icon(
          Icons.add_circle,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: listView(),
    );
  }

  Widget listView() {
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return cardContact(context, contacts[index], showOption);
        });
  }

  void showOption(BuildContext context, Contact contact) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  color: Colors.deepPurple,
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        child: Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                          showPageContact(contact: contact);
                        },
                      ),
                      FlatButton(
                        child: Icon(Icons.call, color: Colors.white),
                        onPressed: () {
                          launch("tel: ${contact.phone}");
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          deleteContact(context, contact);
                        },
                      ),
                    ],
                  ),
                );
              });
        });
  }

  void deleteContact(BuildContext context, Contact contact) async {
    if (contact != null) {
      await ContactRepository(contact: contact).delete();
    }
    setState(() {
      ContactRepository().fetchAll().then((values) => contacts = values);
    });
    Navigator.pop(context);
  }

  void showPageContact({Contact contact}) async {
    final contactEditor = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactPage(contact: contact),
        ));
    if (contactEditor != null) {
      if (contact != null) {
        await ContactRepository(contact: contactEditor).update();
      } else {
        await ContactRepository(contact: contactEditor).save();
      }
    }
    setState(() {
      ContactRepository().fetchAll().then((values) => contacts = values);
    });
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderAsc:
        contacts.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case OrderOptions.orderDesc:
        contacts.sort(
                (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
    }
    setState(() {

    });
  }
}
