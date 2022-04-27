import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/main.dart';
import 'package:websales/src/account.page.dart';

export 'auth.signIn.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:websales/models/product.model.dart';

import 'package:shared_preferences/shared_preferences.dart';

String url = "192.168.1.18:3000";

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);
  @override
  State<Auth> createState() => AuthState();
}

bool logged = false;

class AuthState extends State<Auth> {
  @override
  initState() {
    super.initState();
    getUserToken();
  }

  void getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token != null) {
      setState(() {
        logged = true;
      });
      Navigator.pushReplacementNamed(context, '/myAccount');
    }
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          logged ? 'Profile' : 'Authentication',
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        // child: logged ? MyAccount() : AuthConnexion(),
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
  final _formKey = GlobalKey<FormState>();

  logIn(finalEmail, finalPassword) async {
    try {
      var response = await http.post(
        Uri.http(url, "/api/users/login"),
        body: jsonEncode({
          "email": finalEmail,
          "password": finalPassword,
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      print("TEST RESPONSE");
      var data = json.decode(response.body);
      print(data['token']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['token']);
      logged = true;
      Navigator.pushReplacementNamed(context, '/');
    } catch (err) {
      print("ERROR : " + err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String? finalEmail = "";
    String? finalPassword = "";

    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(25)),
            Text(
              'WEB\$ALES',
              style: GoogleFonts.nunito(
                color: colorNav,
                fontSize: 45,
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
                  finalEmail = email;
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
                finalPassword = password;
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
                    logIn(finalEmail, finalPassword);
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
