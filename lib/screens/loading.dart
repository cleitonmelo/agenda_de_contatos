import 'package:agenda_de_contatos/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return _loading();
  }
}

Widget _loading(){
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.deepPurpleAccent, Colors.deepPurple],
        ),
        navigateAfterSeconds: Home(),
        loaderColor: Colors.transparent,
      ),
      Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 120,
                ),
              ),
              Text('Person Contacts', style: GoogleFonts.abel(fontSize: 15.0, color: Colors.white, decoration: TextDecoration.none))
            ],
          )),
    ],
  );
}
