import 'package:flutter/material.dart';
import 'package:websales/src/add.page.dart';
import 'package:websales/src/auction.page.dart';
import 'package:websales/src/auth.signIn.dart';
import 'package:websales/src/auth.signUp.dart';
import 'package:websales/src/bid.page.dart';
import 'src/account.page.dart';
import 'src/home.page.dart';

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
      // title: 'WebSales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => const Home(),
        '/myAuction': (context) => const MyAuction(),
        '/myBid': (context) => const MyBid(),
        '/auth': (context) => const Auth(),
        '/authSignUp': (context) => const AuthInscription(),
        '/myAccount': (context) => const MyAccount(),
        '/addBid': (context) => const Add(),
      },
      home: const DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            labelColor: colorNav,
            tabs: [
              Tab(icon: Icon(Icons.account_balance)),
              Tab(icon: Icon(Icons.card_travel)),
              Tab(icon: Icon(Icons.add_shopping_cart)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
          body: TabBarView(
            children: [Home(), MyBid(), MyAuction(), Auth()],
          ),
        ),
      ),
    );
  }
}
