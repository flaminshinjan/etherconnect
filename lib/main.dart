import 'package:flutter/material.dart';
import 'screens/wallet_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EtherConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WalletPage(),
    );
  }
}
