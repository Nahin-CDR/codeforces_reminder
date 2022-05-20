
import 'dart:async';
import 'package:codeforces_reminder/checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'menus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),(){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:(context) =>Checker()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
        backgroundColor: Colors.white70,
       body: SafeArea(
         child: Column(
           mainAxisSize: MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             Flexible(
                 flex: 2,
                 child: Image(image: AssetImage("images/cff.png")
                 )
             ),
             Flexible(
                 flex: 1,
                 child:  SpinKitRipple(
                   color: Colors.white,
                   size: 100,
                 )),
             Flexible(
                 flex: 2,
                 child:  Image(image: AssetImage("images/kk2.png"),
                   height:  MediaQuery.of(context).size.height-20,
                 )),
           ],
         ),
       ),
     ),
    );
  }
}
