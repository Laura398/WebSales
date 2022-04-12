import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/main.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => MyAccountState();
}

class MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My account',
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
          child: const MyAccountData(),
          margin: const EdgeInsets.only(left: 10, right: 10),
        ),
      ),
    );
  }
}

class MyAccountData extends StatefulWidget {
  const MyAccountData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAccountDataState();
}

class MyAccountDataState extends State<MyAccountData> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 10, left: 200),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Se déconnecter'),
                style: TextButton.styleFrom(
                    alignment: Alignment.center,
                    elevation: 5,
                    primary: Colors.black,
                    backgroundColor: Colors.grey.shade200,
                    minimumSize: const Size(10, 30),
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    )),
              )),
          Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Contact',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'First name',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(18),
                      labelStyle: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: 150,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Last name',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(18),
                      labelStyle: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: TextFormField(
              validator: (email) {
                if (isEmailValid(email!)) {
                  return null;
                } else {
                  return 'Email is not valid';
                }
              },
              decoration: InputDecoration(
                labelText: 'e-mail',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(18),
                labelStyle: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: 'Numéro de téléphone',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(18),
                labelStyle: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Coordonnées',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Adresse',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(18),
                labelStyle: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Ville',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(18),
                      labelStyle: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(top: 21.5),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 5,
                    decoration: InputDecoration(
                      labelText: 'Code Postale',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(18),
                      labelStyle: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Confirmer'),
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
              ))
        ],
      ),
    );
  }

  bool isEmailValid(String email) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
