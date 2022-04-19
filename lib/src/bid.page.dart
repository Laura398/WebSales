import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/main.dart';

class MyBid extends StatefulWidget {
  const MyBid({Key? key}) : super(key: key);

  @override
  State<MyBid> createState() => MyBidState();
}

class MyBidState extends State<MyBid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My bids',
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
        padding: EdgeInsets.only(left: 10, top: 20, right: 10),
        child: MyBidData(),
      ),
    );
  }
}

class MyBidData extends StatefulWidget {
  const MyBidData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyBidDataState();
}

class MyBidDataState extends State<MyBidData> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/addBid',
              );
            },
            child: const Text('Ajouter une offre'),
            style: TextButton.styleFrom(
              alignment: Alignment.center,
              elevation: 10,
              primary: Colors.white,
              backgroundColor: colorNav,
              minimumSize: const Size.fromHeight(42),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            )));
  }
}
