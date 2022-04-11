import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/main.dart';

export 'auth.signIn.dart';

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
        child: Container(
          child: const AuthConnexion(),
          margin: const EdgeInsets.only(left: 30, right: 30),
        ),
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(25)),
          Text(
            'WEB\$ALES',
            style: GoogleFonts.nunito(
              color: colorNav,
              fontSize: 50,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          const Text(
            'Connexion',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
          ),
          TextFormField(
              validator: (email) {
                if (isEmailValid(email!)) {
                  return null;
                } else {
                  return 'Email is not valid';
                }
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(18),
                labelText: 'E-mail',
                labelStyle: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              )),
          const Padding(padding: EdgeInsets.all(10)),
          TextFormField(
            validator: (password) {
              if (isPasswordValid(password)) {
                return null;
              } else {
                return 'Password is not valid';
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(18),
              labelText: 'Mot de passe',
              labelStyle: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(18)),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              child: const Text('Connexion'),
              style: TextButton.styleFrom(
                  alignment: Alignment.center,
                  elevation: 10,
                  primary: Colors.white,
                  backgroundColor: colorNav,
                  minimumSize: const Size(30, 40),
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  )),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
            ),
          ),
          SizedBox(
            child: ElevatedButton(
              child: const Text('Inscription'),
              style: TextButton.styleFrom(
                elevation: 0,
                primary: Colors.black,
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/authSignUp',
                );
              },
            ),
          )
        ],
      ),
    );
  }

  bool isPasswordValid(String? password) => password!.length >= 5;
  bool isEmailValid(String email) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
