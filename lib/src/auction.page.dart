import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/main.dart';
import 'package:image_picker/image_picker.dart';

import 'home.page.dart';

import 'package:flutter/services.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:websales/models/product.model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:jwt_decode/jwt_decode.dart';

String url = "10.31.32.47:3000";

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
          'My auctions',
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

bool logged = false;
String userId = "";

class MyAuctionDataState extends State<MyAuctionData> {
  @override
  initState() {
    super.initState();
    getUserToken();
    print("LOGGED : ");
    print(logged);

    getData().then((p) {
      if (p != null) {
        setState(() {
          print(" data p start");
          print(p);
          print(" data p end");
          productsList = p;
          productFinalList = p;
        });
      }
    });
  }

  void getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token != null) {
      setState(() {
        logged = true;
        Map<String, dynamic> payload = Jwt.parseJwt(token);
        userId = payload['userId'];
      });
    }
  }

  DateTime dateToShow = DateTime.now();
  String text = '';
  int price = 1;
  int startPrice = 1;
  int endPrice = 10000;
  List productsList = [];
  List productFinalList = [];

  getData() async {
    try {
      var response = await http.get(Uri.http(url, "/api/products/$userId"));
      List<Product> products = List<Product>.from(
          json.decode(response.body).map((p) => Product.fromJson(p)));
      print(products.length);
      return products;
    } catch (err) {
      print("ERROR MESSAGE : " + err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (logged)
          SizedBox(
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
          ),
        if (logged) SizedBox(height: 20),
        if (logged)
          Column(
            children: productFinalList
                .map((product) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/product',
                        arguments: {'product': product, 'mine': "mine"},
                      );
                    },
                    child: ProductCard(product)))
                .toList(),
          )
        else
          Container(
            child: Center(
              child: Text(
                "Veuillez vous connecter pour accéder à ces informations.",
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        if (!logged)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/auth',
                );
              },
              child: const Text('Connexion'),
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
          ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product productData;

  ProductCard(this.productData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 4,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              image: DecorationImage(
                // image: Image.network(
                //   "${productData.picture}",
                // ),
                image: productData.picture != null
                    ? NetworkImage(productData.picture.toString())
                    : NetworkImage(
                        "https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg"), // if image is online
                fit: BoxFit.cover,
              ), // if image is local
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productData.title!,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  productData.basePrice.toString() + '\€',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${productData.seller_first_name} ${productData.seller_last_name}",
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: d_green,
                      size: 14.0,
                    ),
                    productData.endOfTheAuction != null
                        ? Text(
                            DateTime.parse(productData.endOfTheAuction!)
                                    .day
                                    .toString()
                                    .padLeft(2, '0') +
                                "/" +
                                DateTime.parse(productData.endOfTheAuction!)
                                    .month
                                    .toString()
                                    .padLeft(2, '0') +
                                "/" +
                                DateTime.parse(productData.endOfTheAuction!)
                                    .year
                                    .toString(),
                            // productData['date'].day.toString().padLeft(2, '0') +
                            //     "/" +
                            //     productData['date'].month.toString().padLeft(2, '0') +
                            //     "/" +
                            //     productData['date'].year.toString(),
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 3, 10, 0),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  productData.bidders!.length.toString() + ' acheteurs',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
