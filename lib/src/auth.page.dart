import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
export 'auth.page.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class Auth extends StatefulWidget {
  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Authentication',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
