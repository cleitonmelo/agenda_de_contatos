import 'dart:io';

import 'package:agenda_de_contatos/helpers/page_helper.dart';
import 'package:agenda_de_contatos/model/contact.dart';
import 'package:agenda_de_contatos/screens/home.dart';
import 'package:agenda_de_contatos/screens/style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool _edited = false;
  Contact contact;
  final nameFocus = FocusNode();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  void _isEditing() {
    _nameController.text = this.contact.name;
    _emailController.text = this.contact.email;
    _phoneController.text = this.contact.phone;
  }

  void _initContactPage() {
    contact = widget.contact == null
        ? Contact()
        : Contact.fromMap(widget.contact.toMap());

    if (widget.contact != null) {
      this._isEditing();
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO verificar a nomenclatura correta para inicializar
    this._initContactPage();
  }

  void hasEdited() => _edited = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(contact.name ?? "Novo Contato",
              style: GoogleFonts.abel(color: Colors.white, fontSize: 30.0)),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: this._onPressed,
          child: Icon(
            Icons.save,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: form(),
        ));
  }

  Widget form() {
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            GestureDetector(
              child: imageForm(),
            ),
            Card(
                color: Colors.deepPurpleAccent,
                elevation: 5,
                shadowColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: detailForm()),
          ],
        ));
  }

  Widget imageForm() {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: contact.image == null
                  ? AssetImage("images/person.png")
                  : FileImage(File(contact.image)))),
    );
  }

  Widget detailForm() {
    return Container(
      padding: EdgeInsets.only(bottom: 50.0),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: _nameController,
                focusNode: nameFocus,
                decoration:
                    Style.inputDecoration(text: "Nome", icon: Icons.person_pin),
                style: GoogleFonts.abel(color: Colors.white, fontSize: 20.0),
                onChanged: (text) {
                  this.hasEdited();
                  contact.name = text;
                },
                keyboardType: TextInputType.text,
              )),
          Container(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: _emailController,
                decoration:
                    Style.inputDecoration(text: "Email", icon: Icons.email),
                style: GoogleFonts.abel(color: Colors.white, fontSize: 20.0),
                onChanged: (text) {
                  this.hasEdited();
                  contact.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              )),
          Container(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: _phoneController,
                decoration: Style.inputDecoration(
                    text: "Telefone", icon: Icons.phone_android),
                style: GoogleFonts.abel(color: Colors.white, fontSize: 20.0),
                onChanged: (text) {
                  this.hasEdited();
                  contact.phone = text;
                },
                keyboardType: TextInputType.phone,
              )),
        ],
      ),
    );
  }

  void _onPressed(){
    if(_isValidName()){
      Navigator.pop(context,contact);
    }
    FocusScope.of(context).requestFocus(nameFocus);
  }

  bool _isValidName() {
    return _nameController.text != null && _nameController.text.isNotEmpty;
  }

}
