import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:websales/models/product.model.dart';

import 'package:shared_preferences/shared_preferences.dart';

String url = "10.31.32.47:3000";

const d_green = Color.fromARGB(255, 139, 199, 233);

class OneProduct extends StatefulWidget {
  const OneProduct({Key? key}) : super(key: key);

  @override
  StateOneProduct createState() => StateOneProduct();
}

class StateOneProduct extends State<OneProduct> {
  String productId = "";
  int myBidPrice = 0;
  bool logged = false;

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
    }
  }

  updateBid(myBidPrice) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      var response = await http.patch(
        Uri.http(url, "/api/products/bids/$productId"),
        body: jsonEncode({
          "bidder_bid_amount": myBidPrice,
        }),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      // return response;
    } catch (err) {
      print("ERROR : " + err.toString());
    }
  }

  deleteProduct() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      var response = await http.delete(
        Uri.http(url, "/api/products/$productId"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      // return response;
    } catch (err) {
      print("ERROR : " + err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    bool mine = false;

    if (arguments['mine'] != null) {
      mine = true;
    }

    productId = arguments['product'].sId;

    int bidderPrice = 0;
    List bidders = arguments['product'].bidders;
    if (arguments['product'].bidders != null) {
      bidders.sort((a, b) => a.bidderAmount.compareTo(b.bidderAmount));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${arguments['product'].title}',
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          image: DecorationImage(
                            // image: Image.network(
                            //   "${productData.picture}",
                            // ),
                            image: MemoryImage(base64Decode(arguments['product']
                                .picture)), // if image is online
                            fit: BoxFit.cover,
                          ), // if image is local
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Text(
                  "Veudeur : ${arguments['product'].seller_first_name} ${arguments['product'].seller_last_name}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
              ),
              Container(
                child: Text(
                  "Prix de base : ${arguments['product'].basePrice} €",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
              ),
              bidders.length > 0
                  ? Container(
                      child: Text(
                        "Prix actuel : ${bidders.last.bidderAmount} €",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    )
                  : Container(
                      child: Text(
                        "Prix actuel : ${arguments['product'].basePrice} €",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    ),
              SizedBox(height: 30),
              Container(
                child: Text(
                  '${arguments['product'].description}',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                padding: EdgeInsets.all(16),
              ),
              SizedBox(height: 30),
              if (!mine & logged)
                Container(
                  child: ElevatedButton(
                    child: const Text('Enchérir'),
                    style: TextButton.styleFrom(
                        alignment: Alignment.center,
                        elevation: 10,
                        primary: Colors.white,
                        backgroundColor: d_green,
                        minimumSize: const Size(30, 40),
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        )),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                  ),
                ),
              if (mine)
                Container(
                  child: ElevatedButton(
                    child: const Text('Confirmer l\'achat'),
                    style: TextButton.styleFrom(
                        alignment: Alignment.center,
                        elevation: 10,
                        primary: Colors.white,
                        backgroundColor: d_green,
                        minimumSize: const Size(30, 40),
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        )),
                    onPressed: () {
                      showConfirmDialog(context);
                    },
                  ),
                ),
              if (mine) SizedBox(height: 30),
              if (mine)
                Container(
                  child: ElevatedButton(
                    child: const Text('Supprimer le produit'),
                    style: TextButton.styleFrom(
                        alignment: Alignment.center,
                        elevation: 10,
                        primary: Colors.white,
                        backgroundColor: d_green,
                        minimumSize: const Size(30, 40),
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        )),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Annuler"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Confirmer"),
      onPressed: () {
        deleteProduct();
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Suppression du produit"),
      content: Text(
          "Cette action est irréversible. Etes-vous sûr de vouloir supprimer ce produit ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showConfirmDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        deleteProduct();
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation de vente"),
      content: Text("Le produit a été vendu !"),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Enchérir',
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Prix proposé : ',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
            ),
            onChanged: (myBidPriceText) => setState(() {
              myBidPrice = int.parse(myBidPriceText);
            }),
          ),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            updateBid(myBidPrice);
            Navigator.pushReplacementNamed(context, '/');
          },
          // textColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.check,
            size: 26,
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(10),
            primary: d_green,
          ),
        ),
      ],
    );
  }
}
