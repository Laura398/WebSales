import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        padding: EdgeInsets.only(left: 10, top: 20),
        child: Text('No Bid yet...'),
      ),
    );
  }
}
