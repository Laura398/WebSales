import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth.signUp.dart';
export 'auth.page.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);
  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: AuthConnexion(),
      ),
    );
  }
}

class AuthConnexion extends StatefulWidget {
  const AuthConnexion({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => Connexion();
}

class Connexion extends State<AuthConnexion> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(50)),
          const Text(
            'Connexion',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50),
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(18),
              labelText: 'Username',
              labelStyle: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(18),
              labelText: 'Password',
              labelStyle: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(18)),
          RaisedButton(
            child: Text('Login'),
            onPressed: () {},
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/authSignUp',
              );
            },
            child: Text('Sign up'),
          ),
        ],
      ),
    );
  }
}
