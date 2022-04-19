// import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:websales/models/product.model.dart';

const d_green = Color.fromARGB(255, 139, 199, 233);

String url = "10.31.37.28:3000";

// void myFunction() async {
//     var data = {};
//     var response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//         print(reponse.body);
//     } else {
//        print('A network error occurred');
//     }
// }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(), body: SingleChildScrollView(child: MainPage()));
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        'Market',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  SearchSection createState() => SearchSection();
}

class SearchSection extends State<MainPage> {
  // final List productsList =
  // [
  //   {
  //     'title': 'Produit 1',
  //     'firstname': 'Jeam-Michel',
  //     'lastname': 'MACHIN',
  //     'date': DateTime(2023, 1, 1),
  //     'buyers': 36,
  //     'picture': 'assets/images/image1.jpg',
  //     'price': 180,
  //   },
  //   {
  //     'title': 'Produit 2',
  //     'firstname': 'Bérénice',
  //     'lastname': 'TRUC',
  //     'date': DateTime(2022, 6, 1),
  //     'buyers': 36,
  //     'picture': 'assets/images/image2.jpg',
  //     'price': 100,
  //   },
  //   {
  //     'title': 'Produit 3',
  //     'firstname': 'Jeam-Michel',
  //     'lastname': 'MACHIN',
  //     'date': DateTime(2023, 1, 1),
  //     'buyers': 36,
  //     'picture': 'assets/images/image1.jpg',
  //     'price': 500,
  //   },
  //   {
  //     'title': 'Produit 4',
  //     'firstname': 'Bérénice',
  //     'lastname': 'TRUC',
  //     'date': DateTime(2022, 6, 1),
  //     'buyers': 36,
  //     'picture': 'assets/images/image2.jpg',
  //     'price': 800,
  //   },
  // ];

  DateTime dateToShow = DateTime.now();
  String text = '';
  int price = 1;
  int startPrice = 1;
  int endPrice = 10000;
  List productsList = [];
  List productFinalList = [];
  RangeValues _currentRangeValues = const RangeValues(1, 10000);

  getData() async {
    try {
      var response = await http.get(Uri.http(url, "/api/products"));
      // print("TEST ok");
      // print(response);
      // print(response.statusCode);
      // print(response.body);
      List<Product> products = List<Product>.from(
          json.decode(response.body).map((p) => Product.fromJson(p)));
      // List titles = [];
      // products.forEach((p) => titles.add(p.title));
      // print("TITLES");
      // print(titles)
      return products;
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();

    getData().then((p) {
      setState(() {
        productsList = p;
        productFinalList = p;
        print("1");
        print(productsList);
        print("2");
        print(productFinalList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                    onChanged: (text) =>
                        search(text, dateToShow, startPrice, endPrice),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: dateToShow,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    // if 'CANCEL' => null
                    if (newDate == null) return;
                    // if 'OK' => DateTime
                    setState(() {
                      dateToShow = newDate;
                    });
                    search(text, dateToShow, startPrice, endPrice);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choisir une date',
                        style: GoogleFonts.nunito(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${dateToShow.day.toString().padLeft(2, '0')}/${dateToShow.month.toString().padLeft(2, '0')}/${dateToShow.year}',
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    //
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choisir un prix',
                        style: GoogleFonts.nunito(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${startPrice.toString()}€ - ${endPrice.toString().padLeft(2, '0')}€',
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${productFinalList.length} produits trouvés',
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Column(
            children: productFinalList
                .map((product) => ProductCard(product))
                .toList(),
          ),
        ],
      ),
    );
  }

  void search(String text, DateTime dateToShow, int startPrice, int endPrice) {
    setState(() {
      productFinalList = [];
    });
    List products = productsList;
    String lowerCaseText = text.toLowerCase();
    products.forEach((product) {
      print(DateTime.parse(product.endOfTheAuction));
      print(DateTime.parse(dateToShow.toString()));

      print(dateToShow);
      String lowerCaseTitle = product.title.toLowerCase();
      if (dateToShow.day == DateTime.now().day &&
          dateToShow.month == DateTime.now().month &&
          dateToShow.year == DateTime.now().year) {
        if (lowerCaseTitle.contains(lowerCaseText)) {
          if (product.basePrice >= startPrice &&
              product.basePrice <= endPrice) {
            if (!productFinalList.contains(product)) {
              setState(() {
                productFinalList.add(product);
              });
            }
            // setState(() {
            //   productFinalList.add(product);
            // });
          }
        }
      } else if (DateTime.parse(product.endOfTheAuction)
              .isBefore(DateTime.parse(dateToShow.toString())) &&
          lowerCaseTitle.contains(lowerCaseText) &&
          product.basePrice >= startPrice &&
          product.basePrice <= endPrice) {
        if (!productFinalList.contains(product)) {
          setState(() {
            productFinalList.add(product);
          });
        }
      } else {
        setState(() {
          productFinalList.remove(product);
        });
      }
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Prix',
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Entre',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextFormField(
              initialValue: "${startPrice.toString()}",
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (startPriceText) => setState(() {
                    startPrice = int.parse(startPriceText);
                  })),
          Text(
            'et',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextFormField(
              initialValue: "${endPrice.toString()}",
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (endPriceText) => setState(() {
                    endPrice = int.parse(endPriceText);
                  })),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            search(text, dateToShow, startPrice, endPrice);
            Navigator.of(context).pop();
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
                image: AssetImage(
                  "assets/images/image1.jpg",
                ),
                // image: NetworkImage(productData['picture']), // if image is online
                fit: BoxFit.cover,
              ), // if image is local
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  right: -15,
                  child: MaterialButton(
                    color: Colors.white,
                    shape: CircleBorder(),
                    onPressed: () {},
                    child: Icon(
                      Icons.favorite_outline_rounded,
                      color: d_green,
                      size: 20,
                    ),
                  ),
                )
              ],
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
                  "Nom Prénom",
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
