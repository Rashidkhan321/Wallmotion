import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallmotion/Data/Networ/Api_Services/Apiservices.dart';
import 'package:wallmotion/components/spalsh_screen.dart';

import 'components/themchnage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [

      ChangeNotifierProvider(create: (_) => photodata()),
      ChangeNotifierProvider(create: (_) => photodata()),
      ChangeNotifierProvider(create: (_) => ThemeProvider(ThemeData.light())),


    ],
        child:
        Consumer<ThemeProvider>(builder: (index, value, child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: value.themeData,
            home: splash(),
          );
        })
        );
  }

}