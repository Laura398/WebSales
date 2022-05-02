// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:websales/main.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class MyAccount extends StatefulWidget {
//   const MyAccount({Key? key}) : super(key: key);

//   @override
//   State<MyAccount> createState() => MyAccountState();
// }

// class MyAccountState extends State<MyAccount> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'My Account',
//           style: GoogleFonts.nunito(
//             color: Colors.black,
//             fontSize: 22,
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: const MyAccountData(),
//           margin: const EdgeInsets.only(left: 10, right: 10),
//         ),
//       ),
//     );
//   }
// }

// class MyAccountData extends StatefulWidget {
//   const MyAccountData({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => MyAccountDataState();
// }

// class MyAccountDataState extends State<MyAccountData> {
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: <Widget>[
//           Container(
//               margin: const EdgeInsets.only(top: 20, left: 0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 color: colorNav,
//               ),
//               child: IconButton(
//                 onPressed: () {
//                   logOut() async {
//                     SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                     prefs.remove("token");
//                     Navigator.pushReplacementNamed(context, '/');
//                   }

//                   logOut();
//                 },
//                 icon: const Icon(Icons.power_settings_new),
//                 iconSize: 32,
//                 color: Colors.white,
//               )),
//           Container(
//             margin: const EdgeInsets.only(left: 10, right: 10, top: 12),
//             child: Text(
//               'Contact',
//               style: GoogleFonts.nunito(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 12),
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   width: 150,
//                   margin: const EdgeInsets.only(left: 10),
//                   child: TextFormField(
//                     onChanged: (titleText) => setState(() {
//                       finalFirstName = titleText;
//                     }),
//                     decoration: InputDecoration(
//                       labelText: 'First name',
//                       border: const OutlineInputBorder(),
//                       contentPadding: const EdgeInsets.all(18),
//                       labelStyle: GoogleFonts.nunito(
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Padding(padding: EdgeInsets.all(10)),
//                 SizedBox(
//                   width: 150,
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Last name',
//                       border: const OutlineInputBorder(),
//                       contentPadding: const EdgeInsets.all(18),
//                       labelStyle: GoogleFonts.nunito(
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 18, left: 10, right: 10),
//             child: TextFormField(
//               validator: (email) {
//                 if (isEmailValid(email!)) {
//                   return null;
//                 } else {
//                   return 'Email is not valid';
//                 }
//               },
//               decoration: InputDecoration(
//                 labelText: 'E-mail',
//                 border: const OutlineInputBorder(),
//                 contentPadding: const EdgeInsets.all(18),
//                 labelStyle: GoogleFonts.nunito(
//                   color: Colors.black,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 18, left: 10, right: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.phone,
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               maxLength: 10,
//               decoration: InputDecoration(
//                 labelText: 'Numéro de téléphone',
//                 border: const OutlineInputBorder(),
//                 contentPadding: const EdgeInsets.all(18),
//                 labelStyle: GoogleFonts.nunito(
//                   color: Colors.black,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(12),
//             child: Text(
//               'Coordonnées',
//               style: GoogleFonts.nunito(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Adresse',
//                 border: const OutlineInputBorder(),
//                 contentPadding: const EdgeInsets.all(18),
//                 labelStyle: GoogleFonts.nunito(
//                   color: Colors.black,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             children: <Widget>[
//               Container(
//                 width: 150,
//                 margin: const EdgeInsets.only(left: 10),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Ville',
//                     border: const OutlineInputBorder(),
//                     contentPadding: const EdgeInsets.all(18),
//                     labelStyle: GoogleFonts.nunito(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//               ),
//               const Padding(padding: EdgeInsets.all(10)),
//               Container(
//                 width: 150,
//                 margin: const EdgeInsets.only(top: 21.5),
//                 child: TextFormField(
//                   keyboardType: TextInputType.phone,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   maxLength: 5,
//                   decoration: InputDecoration(
//                     labelText: 'Code Postale',
//                     border: const OutlineInputBorder(),
//                     contentPadding: const EdgeInsets.all(18),
//                     labelStyle: GoogleFonts.nunito(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//               margin: const EdgeInsets.only(left: 10, right: 10),
//               width: 180,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: const Text('Confirmer'),
//                 style: TextButton.styleFrom(
//                     alignment: Alignment.center,
//                     elevation: 10,
//                     primary: Colors.white,
//                     backgroundColor: colorNav,
//                     minimumSize: const Size(30, 40),
//                     shape: const BeveledRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(3))),
//                     textStyle: const TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w800,
//                     )),
//               ))
//         ],
//       ),
//     );
//   }

//   bool isEmailValid(String email) {
//     Pattern pattern =
//         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
//     RegExp regex = RegExp(pattern.toString());
//     return regex.hasMatch(email);
//   }
// }
