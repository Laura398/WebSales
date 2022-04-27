import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/main.dart';

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
        padding: EdgeInsets.only(left: 10, top: 20, right: 10),
        child: MyAuctionData(),
      ),
    );
  }
}

class MyAuctionData extends StatefulWidget {
  const MyAuctionData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAuctionDataState();
}

class MyAuctionDataState extends State<MyAuctionData> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/addAuction',
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
        ),
      ),
    );
  }
}
