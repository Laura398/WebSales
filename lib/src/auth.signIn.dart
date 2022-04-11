import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        key: _formKey,
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(50)),
          Container(
            child: Text(
              'WEB\$ALES',
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 50,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          // const Text(
          //   'Connexion',
          //   style: TextStyle(
          //     fontSize: 40,
          //     fontWeight: FontWeight.w800,
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.all(50),
          ),
          TextFormField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.email(context),
              ]),
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
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.minLength(context, 6),
            ]),
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
                if (_formKey.currentState!.saveAndValidate()) {
                  print(_formKey.currentState!.value['email']);
                  print(_formKey.currentState!.value['password']);
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
}
