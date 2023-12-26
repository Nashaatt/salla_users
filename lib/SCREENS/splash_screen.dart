import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_shop/WIDGETS/app_name.dart';
import 'package:smart_shop/root_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();

}



class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () => Navigator.push(context, MaterialPageRoute(builder: (c) => RootScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Center(
        child: AppNameTextWidget(
          text: "SALLA",
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
