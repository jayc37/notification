import 'package:notification/LaunchUrl2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    HomeApp(),
  );
}
class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}
class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaunchUrlDemo(),
    );
  }
}
