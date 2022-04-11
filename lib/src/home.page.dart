import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const d_green = Color.fromARGB(255, 139, 199, 233);

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
  SearchSection createState() => SearchSection();
}

class SearchSection extends State<MainPage> {
  final List productsList = [
    {
      'title': 'Produit 1',
      'firstname': 'Jeam-Michel',
      'lastname': 'MACHIN',
      'date': DateTime(2023, 1, 1),
      'buyers': 36,
      'picture': 'assets/images/image1.jpg',
      'price': '180',
    },
    {
      'title': 'Produit 2',
      'firstname': 'Bérénice',
      'lastname': 'TRUC',
      'date': DateTime(2022, 6, 1),
      'buyers': 36,
      'picture': 'assets/images/image2.jpg',
      'price': '180',
    },
    {
      'title': 'Produit 3',
      'firstname': 'Jeam-Michel',
      'lastname': 'MACHIN',
      'date': DateTime(2023, 1, 1),
      'buyers': 36,
      'picture': 'assets/images/image1.jpg',
      'price': '180',
    },
    {
      'title': 'Produit 4',
      'firstname': 'Bérénice',
      'lastname': 'TRUC',
      'date': DateTime(2022, 6, 1),
      'buyers': 36,
      'picture': 'assets/images/image2.jpg',
      'price': '180',
    },
  ];

  DateTime dateToShow = DateTime.now();
  String text = '';
  List productFinalList = [];

  @override
  void initState() {
    super.initState();
    productFinalList = productsList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
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
                    onChanged: (text) => search(text, dateToShow),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
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
                  search(text, dateToShow);
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
                      '${dateToShow.day.toString().padLeft(2, '0')} ${dateToShow.month.toString().padLeft(2, '0')} ${dateToShow.year}',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
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
                      'prix',
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
                        height: 50,
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

  void search(String text, DateTime dateToShow) {
    productFinalList = [];
    List products = productsList;
    String lowerCaseText = text.toLowerCase();
    products.forEach((product) {
      String lowerCaseTitle = product['title'].toLowerCase();
      if (dateToShow.day == DateTime.now().day) {
        if (lowerCaseTitle.contains(lowerCaseText)) {
          if (!productFinalList.contains(product)) {
            setState(() {
              productFinalList.add(product);
            });
          }
        }
      } else if (product['date'].isBefore(dateToShow) &&
          lowerCaseTitle.contains(lowerCaseText)) {
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
}

class ProductCard extends StatelessWidget {
  final Map productData;
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
                  productData['picture'],
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
                  productData['title'],
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  productData['price'] + '\€',
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
                  productData['firstname'] + " " + productData['lastname'],
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
                    Text(
                      productData['date'].day.toString().padLeft(2, '0') +
                          "/" +
                          productData['date'].month.toString().padLeft(2, '0') +
                          "/" +
                          productData['date'].year.toString(),
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
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
                  productData['buyers'].toString() + ' acheteurs',
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
