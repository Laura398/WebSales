import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAuction extends StatefulWidget {
  @override
  State<MyAuction> createState() => MyAuctionState();
}

class MyAuctionState extends State<MyAuction> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}
