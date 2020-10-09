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
}
