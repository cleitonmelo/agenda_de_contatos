import 'package:agenda_de_contatos/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cardContact(BuildContext context, Contact contact){
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
            Container(
              padding: EdgeInsets.only(left: 5.0),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Nome: ${contact.name}", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.blueGrey)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Email: ${contact.email}", style: GoogleFonts.abel(fontSize: 18.0)),
                    ],
                  ),
                  Row(
                     children: [
                       Text("Telefone: ${contact.phone}", style: GoogleFonts.abel(fontSize: 18.0))
                     ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}