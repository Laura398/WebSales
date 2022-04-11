import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/main.dart';

class AuthInscription extends StatefulWidget {
  const AuthInscription({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => Inscription();
}

class Inscription extends State<AuthInscription> {
  final _formKey = GlobalKey<FormState>();

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
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Form(
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
                  'Inscription',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(10),
                    labelText: 'Prénom',
                    labelStyle: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(10),
                    labelText: 'Nom',
                    labelStyle: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
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
                    contentPadding: const EdgeInsets.all(10),
                    labelText: 'E-mail',
                    labelStyle: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
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
                    contentPadding: const EdgeInsets.all(10),
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
                    child: const Text('Envoyer'),
                    style: TextButton.styleFrom(
                        elevation: 10,
                        minimumSize: const Size(30, 40),
                        primary: Colors.white,
                        backgroundColor: colorNav,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        )),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pushNamed(
                          context,
                          '/',
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
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
