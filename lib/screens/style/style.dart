import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {

  static InputDecoration inputDecoration({@required text, @required icon}) {
    return InputDecoration(
      icon: Icon(icon, color: Colors.white),
      labelText: text,
      labelStyle: GoogleFonts.abel(color: Colors.white, fontSize: 20.0),
    );
  }

  static imageCircle({@required image}){
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: image == null
                  ? AssetImage("images/person.png")
                  : FileImage(File(image)),
              fit: BoxFit.cover)
      ),
    );
  }
}
