import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAuction extends StatefulWidget {
  const MyAuction({Key? key}) : super(key: key);

  @override
  State<MyAuction> createState() => MyAuctionState();
}

class MyAuctionState extends State<MyAuction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My auction',
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
        child: Text('No auction yet...'),
      ),
    );
  }
}
