import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const d_green = Color.fromARGB(255, 139, 199, 233);

class OneProduct extends StatefulWidget {
  const OneProduct({Key? key}) : super(key: key);

  @override
  StateOneProduct createState() => StateOneProduct();
}

class StateOneProduct extends State<OneProduct> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    int bidderPrice = 0;
    List bidders = arguments['product'].bidders;
    if (arguments['product'].bidders != null) {
      bidders.sort((a, b) => a.price.compareTo(b.price));
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
      body: Container(
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
                          image: arguments['product'].picture != null
                              ? NetworkImage(
                                  arguments['product'].picture.toString())
                              : NetworkImage(
                                  "https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg"), // if image is online
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
                      "Prix actuel : ${bidders.last.price} €",
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
          ],
        ),
      ),
    );
  }

  int myBidPrice = 0;

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
            print(myBidPrice);
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
