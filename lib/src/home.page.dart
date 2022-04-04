import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/main.dart';

const d_green = Color.fromARGB(255, 139, 199, 233);

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchSection(),
              HotelSection(),
            ],
          ),
        ));
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => new Size.fromHeight(50);
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

class SearchSection extends StatelessWidget {
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
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.search,
                      size: 26,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      primary: d_green,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose date',
                        style: GoogleFonts.nunito(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '12 Dec - 22 Dec',
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Number of rooms',
                        style: GoogleFonts.nunito(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '1 Room - 2 Adults',
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
          ],
        ));
  }
}

class HotelSection extends StatelessWidget {
  final List hotelList = [
    {
      'title': 'Hotel 1',
      'place': 'Webley, London',
      'distance': 2,
      'review': 36,
      'picture': 'images/image1.jpg',
      'price': '180',
    },
    {
      'title': 'Hotel 2',
      'place': 'Webley, London',
      'distance': 2,
      'review': 36,
      'picture': 'images/image2.jpg',
      'price': '180',
    },
    {
      'title': 'Hotel 3',
      'place': 'Webley, London',
      'distance': 2,
      'review': 36,
      'picture': 'images/image1.jpg',
      'price': '180',
    },
    {
      'title': 'Hotel 4',
      'place': 'Webley, London',
      'distance': 2,
      'review': 36,
      'picture': 'images/image2.jpg',
      'price': '180',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '550 products found',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Filters',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.filter_list_outlined,
                        color: d_green,
                        size: 25,
                      ),
                      onPressed: null,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: hotelList.map((hotel) {
              return HotelCard(hotel);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Map hotelData;
  HotelCard(this.hotelData);
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
                  hotelData['picture'],
                ),
                // image: NetworkImage(hotelData['picture']), // if image is online
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
                  hotelData['title'],
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  hotelData['price'] + '\€',
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
                  hotelData['place'],
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: d_green,
                      size: 14.0,
                    ),
                    Text(
                      hotelData['distance'].toString() + ' km to city',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                Text(
                  'per night',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 3, 10, 0),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star_rate,
                      color: d_green,
                      size: 14,
                    ),
                    Icon(
                      Icons.star_rate,
                      color: d_green,
                      size: 14,
                    ),
                    Icon(
                      Icons.star_rate,
                      color: d_green,
                      size: 14,
                    ),
                    Icon(
                      Icons.star_rate,
                      color: d_green,
                      size: 14,
                    ),
                    Icon(
                      Icons.star_rate,
                      color: d_green,
                      size: 14,
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  hotelData['review'].toString() + ' reviews',
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
