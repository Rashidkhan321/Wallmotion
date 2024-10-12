
import 'dart:async';

import 'package:flutter/material.dart';
import '../View/HomeScreen.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  void initState() {

    Timer(Duration(seconds: 5), () {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

    });

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.black,

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
    image: AssetImage('images/Logo.png',
    ),
              fit: BoxFit.fill,),
      ),
      )
    );
  }
}
