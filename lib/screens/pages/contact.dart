import 'package:agenda_de_contatos/model/contact.dart';
import 'package:agenda_de_contatos/screens/style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker _picker = ImagePicker();

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
    return WillPopScope(
        onWillPop: popRequest,
        child: Scaffold(
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
            )));
  }

  Widget form() {
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            GestureDetector(
              child: Style.imageCircle(image: contact.image),
              onTap: () {
                _picker.getImage(source: ImageSource.camera).then((file) {
                  if (file != null) {
                    setState(() {
                      contact.image = file.path;
                    });
                  }
                  return;
                });
              },
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

  void _onPressed() {
    if (_isValidName()) {
      Navigator.pop(context, contact);
    }
    FocusScope.of(context).requestFocus(nameFocus);
  }

  bool _isValidName() {
    return _nameController.text != null && _nameController.text.isNotEmpty;
  }

  Future<bool> popRequest() {
    if (_edited) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("Descartar Alterações?",
                  style: GoogleFonts.abel(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              content: Text("Ao sair as alterações serão perdidas.",
                  style: GoogleFonts.abel(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.deepPurple,
              actions: [
                FlatButton(
                  child: Text("Cancelar",
                      style: GoogleFonts.abel(color: Colors.white)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child:
                      Text("Sim", style: GoogleFonts.abel(color: Colors.white)),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    }
    return Future.value(true);
  }
}
