import 'package:flutter/material.dart';

import 'package:superscanner/super_home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
Future.delayed(const Duration(seconds: 2),(){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomePage()));
});    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(child:Image.asset('assets/logo.jpg')),
    );
  }
}