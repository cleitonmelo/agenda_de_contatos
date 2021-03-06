import 'package:agenda_de_contatos/model/contact.dart';
import 'package:agenda_de_contatos/screens/style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cardContact(BuildContext context, Contact contact, onTap) {
  return GestureDetector(
      onTap: () {
        onTap(context, contact);
      },
      child: Container(
        child: Card(
          color: Colors.deepPurpleAccent,
          elevation: 5,
          shadowColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                        child: Style.imageCircle(image: contact.image),
                        backgroundColor: Colors.deepPurpleAccent,
                    ),
                  title: Text(contact.name,
                      style: GoogleFonts.abel(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white)),
                ),
                Divider(
                  color: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.mail_outline,
                        color: Colors.white,
                      ),
                      Text(contact.email ?? "",
                          style: GoogleFonts.abel(
                              fontSize: 18.0, color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      Text(contact.phone ?? "",
                          style: GoogleFonts.abel(
                              fontSize: 18.0, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
}
