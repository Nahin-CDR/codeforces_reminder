import 'dart:async';
import 'dart:io';
import 'package:codeforces_reminder/checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

String? storedData;
bool _noInternet = false;

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> _sharedData() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      storedData = prefs.getString('handle');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sharedData();
    Timer(const Duration(seconds: 5), () async {
      if (storedData == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Checker()));
      } else {


        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "sync...",
                style: TextStyle(
                    fontSize: 12.00, color: Colors.white),
              ),
              duration: Duration(milliseconds: 1000),
              backgroundColor: Colors.green,
            ));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MENUS()));

          }
        } on SocketException catch (_) {

          setState(() {
            _noInternet = true;
          });

        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white24,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              //Image(image: AssetImage("images/cff.png"))

               Flexible(
                  flex: 2, child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:const [

                 Text("Codeforces",style: TextStyle(color: Colors.blue,fontSize: 30, fontWeight: FontWeight.bold),),
                 Text(" Reminder",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight:FontWeight.bold),)
                ],
              )
              ),
               Flexible(
                  flex: 1,
                  child: _noInternet == true?
                  SizedBox(height: MediaQuery.of(context).size.height/2,child: const Text("\nNo internet !",style: TextStyle(color: Colors.white,fontSize: 18))):const SpinKitRipple(color: Colors.white, size: 100),

              ),
               Flexible(
                  flex: 2,
                  child: Image(
                    image:const AssetImage("images/kk2.png"),
                    height: MediaQuery.of(context).size.height - 20,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
