import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/src/auction.page.dart';
import 'package:websales/src/auth.page.dart';
import 'package:websales/src/settings.page.dart';

import 'src/home.page.dart';
// import 'package:websales/calendar_page.dart';

void main() {
  runApp(const WebSales());
}

const colorNav = Color.fromARGB(255, 139, 199, 233);

class WebSales extends StatelessWidget {
  const WebSales({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: const TabBar(
            labelColor: colorNav,
            tabs: [
              Tab(icon: Icon(Icons.account_balance)),
              Tab(icon: Icon(Icons.add_shopping_cart)),
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.brightness_5)),
            ],
          ),
          body: TabBarView(
            children: [Home(), MyAuction(), Auth(), Settings()],
          ),
        ),
      ),
    );
  }
}
