import 'package:flutter/material.dart';
import 'package:manafood/screens/home.dart';

// void main() {
//   runApp(MyApp());
// }//เขียนแบบเต็ม
main() => runApp(MyApp()); //อย่างย่อ

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primarySwatch: Colors.green),
      title: 'Mana Food',
      home: Home(),
    );
  }
}
