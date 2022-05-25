import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:timezone/data/latest.dart' as tz;
import '../notificationservice.dart';

import 'package:codeforces_reminder/checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'codeforces/contest_list.dart';
import 'codeforces/set_reminder.dart';
import 'codeforces/top_rated.dart';
import 'codeforces/user_contest_list.dart';
import 'codeforces/user_info.dart';
import 'codeforces/user_statistics.dart';
import 'codeforces/user_submission.dart';

class MENUS extends StatefulWidget {
  @override
  State<MENUS> createState() => _MENUSState();
}

List? listResponse;
Map? mapResponse;
bool _loading = true;
String? data;



String? lastContest = "";
int? time = -1;
int? Totalhours = -1;
double hours = -1;
double minutes = -1;
int days = 0;
int sec = 150;
int temp = 0;
double seconds = 0;
double rem1 = 0;
double rem2 = 0;
String? tempTime;

int h = 0;
int m = 0;
int s = 0;






class _MENUSState extends State<MENUS> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> _sharedData() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      data = prefs.getString('handle').toString();
    });
  }


  Future ApiCall_For_upcomingContest() async{
    http.Response response;
    response = await http.get(Uri.parse("https://codeforces.com/api/contest.list?gym=false"));
   // print("Status Code : ${response.statusCode}");
    if(response.statusCode == 200){
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];
        listResponse?.forEach((element) {
          if(element['phase'].toString() == "BEFORE"){
            tempTime = element['relativeTimeSeconds'].toString();
            lastContest = element['name'].toString();
            // print(tempTime);
          }});
      });
    }else{
      print("Error");
    }
    time = int.parse(tempTime!);
    time = time!*(-1);
    sec = time!;
  }
 // int sec = 150;
  int period = 0;
  void startCountDown(){
    Timer.periodic(Duration(seconds:1), (timer) {
      if(sec > 0){
        setState(() {
          hours =sec/3600.round();
          h = hours.toInt();
          rem1 = sec%3600; //remaining seconds after taking hour
          minutes = rem1/60.round();
          m =  minutes.toInt();
          rem2 = rem1%60;
          seconds = rem2;
          s = seconds.toInt();
          sec--;
         // print(sec);
        });
      }else{
        timer.cancel();
      }
    });
  }
  Future ApiCall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://codeforces.com/api/user.info?handles=$data"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];
      });
      String n = listResponse![0]['country'].toString();
      print(n);
    } else {
      print("error");
    }
    setState(() {
      _loading = false;
    });
  }
  @override
  initState() {
    _sharedData();
    ApiCall_For_upcomingContest();
    tz.initializeTimeZones();
    startCountDown();
    super.initState();
    Timer(const Duration(seconds: 3), () {
      ApiCall();
    });
    Timer(const Duration(seconds: 30), () {
      if(_loading == true) {
      showDialog(context: context, builder: (context){
        return AlertDialog(
          backgroundColor: Colors.black,
          title:const Text("Sorry!",style: TextStyle(color: Colors.white)),
          content:const Text("I'm unable to show data,server is not responding..",style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: const Text('exit',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.of(context).size.height;
   // final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Codeforces",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            Text(" Reminder",style: TextStyle(color: Colors.white))
          ],
        ),
        centerTitle: true,
      ),
      body: TryMenu(), //MyMenus(),
    );
  }
}

class TryMenu extends StatelessWidget {
  const TryMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _loading ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [SpinKitRipple(color: Colors.white, size: 120)]))
        : ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                height: 250,
                margin: const EdgeInsets.only(top: 5,left: 10,right: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.white12,)),
                //time remaining
                const Positioned (top: 15, right: 15, child: Text("time remaining :", style: TextStyle(fontSize: 15.00, color: Colors.white70,))),
                //time counter
                Positioned(
                  top: 35,
                  right: 20,
                  child: Text("${h.toString()} : ${m.toString()} : ${s.toString()}",
                    style:const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                //upcoming contest
                const Positioned(
                    top: 135,
                    right: 15,
                    child:
                    Text("upcoming contest : ",
                        style: const TextStyle(
                            fontSize: 15.00,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold
                        ))

                ),
                 Positioned(
                    top: 145,
                    right: 20,
                    child: IconButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            backgroundColor: Colors.black,
                            title:const Text("Upcoming Contest",style: TextStyle(color: Colors.white),),
                            content:  Text("$lastContest",
                                style: const TextStyle(
                                    fontSize: 15.00,
                                    color: Colors.white,

                                )),
                          );
                        });
                      },
                      icon: Icon(FontAwesomeIcons.arrowsToEye,color: Colors.white,),
                    ),


                ),

                //contest name
                // Positioned(
                //     top: 155,
                //     right: 15,
                //     child:  SingleChildScrollView(
                //       scrollDirection: Axis.horizontal,
                //       child:
                //         Text("$lastContest",
                //             style: const TextStyle(
                //                 fontSize: 15.00,
                //                 color: Colors.grey,
                //                 fontWeight: FontWeight.bold
                //             )),
                //     )
                //
                // ),

                //first name
                Positioned(
                  top: 15,
                  left: 20,
                  child:Text("Name : "+listResponse![0]['firstName'].toString(),style: const TextStyle( fontSize: 15.00, color: Colors.white))
                ),
                //country
                 Positioned(
                  top: 35,
                  left: 20,
                  child: Text("From : "+listResponse![0]['country'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white)),
                ),
                //contest rating
                Positioned(
                  top: 55,
                  left: 20,
                  child: Text("Contest Rating : "+listResponse![0]['rating'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white)),
                ),
                //max rating
                Positioned(
                  top: 75,
                  left: 20,
                  child: Text("Max Rating : "+listResponse![0]['maxRating'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white),),
                ),
                //current rank
                Positioned(top: 95, left: 20, child: Text("Current Rank : "+listResponse![0]['rank'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white)),),
                //max rank
                 Positioned(
                  top: 115,
                  left: 20,
                  child: Text("Max Rank : "+listResponse![0]['maxRank'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white),),
                ),
                //profile image
                Positioned(
                top: 190,
                child:CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(listResponse![0]['titlePhoto'].toString()),
                ),
              )
              ],
            ),
            Container(
            margin: EdgeInsets.only(top:55),
            child: Center(child: Text("$data",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white))),
          ),
            Container(
             margin: EdgeInsets.only(top: 8,left: 15,right: 15,bottom: 5),
             child:  Divider(color: Colors.white,thickness: 2),
           ),
            //User contest List
            Container(
              margin:const EdgeInsets.all(10),
              child: InkWell(
                  borderRadius:const BorderRadius.only(bottomRight: Radius.circular(5.00)),
                  onTap: () async {
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) { //checking if network is connected
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sync...",style: TextStyle(fontSize: 12.00, color: Colors.white),),
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserContestList(id:data.toString())));
                      }
                    }on SocketException catch (_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                    }
                  },
                  child: Ink(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration:const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(5.00),
                        )),
                    child: Container(
                        color: Colors.white12,
                        child: Center(
                            child: Row(
                              children: const [
                                Text("         "),
                                Icon(Icons.account_tree_outlined,size: 22,color: Colors.white),
                                Text("  User's Contest List", style: TextStyle(fontSize: 17.00,color: Colors.white)),
                              ],
                            ))),
                  )),
            ),
            //User Statistics
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.white12,
              child: InkWell(
                  borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(50.00),
                      bottomRight: Radius.circular(5.00)),
                  onTap: () async {
                    try {
                      final result =
                          await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "sync...",
                            style: TextStyle(
                                fontSize: 12.00, color: Colors.white),
                          ),
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>UserStatistics(id: data.toString(),)));
                      }
                    } on SocketException catch (_) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text(
                          "You are disconnected from internet...",
                          style: TextStyle(
                              fontSize: 12.00, color: Colors.white),
                        ),
                        duration: Duration(milliseconds: 1000),
                        backgroundColor: Colors.red,
                      ));
                    }

                  },
                  child: Ink(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.only(
                          //  topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(5.00),
                        )),
                    child: Container(
                        child: Center(
                            child: Row(
                              children: const [
                                Text("         "),
                                Icon(
                                  Icons.stacked_line_chart,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                Text("  User's Statistics",
                                    style: TextStyle(
                                        fontSize: 17.00,
                                        color: Colors.white)),
                              ],
                            ))),
                  )),
            ),
            //User Submissions
            Container(
              margin:const EdgeInsets.all(10),
              color: Colors.white12,
              child: InkWell(
                  borderRadius: BorderRadius.only(
                    //  topLeft: Radius.circular(50.00),
                      bottomRight: Radius.circular(5.00)),
                  onTap: () async {
                    try {
                      final result =
                          await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "sync...",
                            style: TextStyle(
                                fontSize: 12.00, color: Colors.white),
                          ),
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>UserSubmission(id: data.toString())));
                      }
                    } on SocketException catch (_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red));
                    }
                  },
                  child: Ink(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration:const BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.00),)),
                    child: Container(
                        child: Center(
                            child: Row(
                              children: const [
                                Text("         "),
                                Icon(
                                  Icons.app_registration,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                Text("  User Submissions",
                                    style: TextStyle(
                                        fontSize: 17.00,
                                        color: Colors.white)),
                              ],
                            ))),
                  )),
            ),
            //ContestList
            Container(
              margin:const EdgeInsets.all(10),
              color: Colors.white12,
              child: InkWell(
                  splashColor: Colors.grey,
                  borderRadius:const BorderRadius.only(bottomRight: Radius.circular(5.00)),
                  onTap: () async {
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sync...",style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.green,));
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>const ContestList()));
                      }
                    } on SocketException catch (_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),),duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                    }
                  },
                  child: Ink(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(5.00),
                        )),
                    child: Container(
                        child: Center(
                            child: Row(
                              children: const [
                                Text("         "),
                                Icon(
                                  Icons.list_alt,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                Text("  Contest List ",
                                    style: TextStyle(
                                        fontSize: 17.00,
                                        color: Colors.white)),
                              ],
                            ))),
                  )),
            ),
            //Set Reminder
            Container(
              color: Colors.white12,
              margin:const EdgeInsets.all(10),
              child: InkWell(
                  borderRadius:const BorderRadius.only(bottomRight: Radius.circular(5.00)),
                  onTap: ()  async {
                     int limit = sec.toInt();
                     if(limit-60>0){
                       limit = limit - 60; //alarm will ring before 60 seconds of contest
                     }
                    NotificationService().showNotification(1, "Codeforces Contest","Your Contest will start soon",limit);
                    showDialog(context: context, builder: (context){return AlertDialog(backgroundColor: Colors.black,
                        title:  Text("Alarm has been set for $lastContest ", style: TextStyle(color: Colors.white,fontSize: 18)),
                        content: Text("You will be notified",style: TextStyle(color: Colors.white)),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: Text("ok",style: TextStyle(color: Colors.white))),
                        ],
                      );
                    });


                    // try {
                    //   final result = await InternetAddress.lookup('google.com');
                    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sync...", style: TextStyle(fontSize: 12.00, color: Colors.white),),duration: Duration(milliseconds: 1000), backgroundColor: Colors.green,));
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const SetReminder()));
                    //   }
                    // } on SocketException catch (_) {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                    // }

                  },
                  child: Ink(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration:const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(5.00),
                        )),
                    child: Container(
                        child: Center(
                            child: Row(
                              children: const [
                                Text("         "),
                                Icon(
                                  Icons.access_alarm,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                Text("  Set Reminder",
                                    style: TextStyle(
                                      fontSize: 17.00,
                                      color: Colors.white,
                                    )),
                              ],
                            ))),
                  )),
            ),
            //Top rated
            Container(
              margin: const EdgeInsets.all(10),
              color: Colors.white12,
              child: InkWell(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5.00)),
                  onTap: () async {
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sync...", style: TextStyle(fontSize: 12.00, color: Colors.white),),duration: Duration(milliseconds: 1000), backgroundColor: Colors.green,));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TopRated()));
                      }
                    } on SocketException catch (_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                    }
                  },
                  child: Ink(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.00),)),
                    child: Center(
                        child: Row(
                          children: const [
                            Text("         "),
                            Icon(Icons.arrow_upward_outlined, size: 22, color: Colors.white,),
                            Text("  Top 10 ", style: TextStyle(fontSize: 17.00, color: Colors.white)),
                          ],
                        )),
                  )),
            ),
            //log out
            Container(
              margin: const EdgeInsets.all(10),
              color: Colors.white12,
              child: InkWell(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5.00)),
                  onTap: () {
                    _deletesharedData();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Checker()));
                  },
                  child: Ink(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.00),)),
                    child: Center(
                        child: Row(
                          children: const [
                            Text("         "),
                            Icon(Icons.logout, size: 22, color: Colors.white,
                            ),
                            Text("  Log out ", style: TextStyle(fontSize: 17.00, color: Colors.white,)),
                          ],
                        )),
                  )),
            ),
          ],
        );
  }
}









// class MyMenus extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _loading
//         ? const Center(child: SpinKitRipple(color: Colors.white, size: 120))
//         : Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.all(7.00),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5.0),
//                   color: Colors.white12,
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         //profile image
//                         Flexible(
//                           flex: 1,
//                           child: Container(
//                             margin: const EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.00),
//                               color: Colors.white,
//                             ),
//                             child: Center(
//                               child: listResponse![0]['titlePhoto'] == null
//                                   ? const Text("Loading data")
//                                   : Container(
//                                       margin: const EdgeInsets.all(2.00),
//                                       width: MediaQuery.of(context).size.width,
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               7,
//                                       child: const Text(""),
//                                       decoration: BoxDecoration(
//                                           color: Colors.green,
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.circular(15.00)),
//                                           image: DecorationImage(
//                                             image: NetworkImage(listResponse![0]
//                                                     ['titlePhoto']
//                                                 .toString()),
//                                             fit: BoxFit.fill,
//                                           )),
//                                     ),
//                             ),
//                           ),
//                         ),
//                         Flexible(
//                             flex: 2,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   listResponse![0]['firstName'].toString(),
//                                   style: TextStyle(
//                                       fontSize: 20.00,
//                                       color: Colors.grey,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 //Country Name
//                                 Container(
//                                   margin: const EdgeInsets.only(top: 10),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(2)),
//                                   child: Center(
//                                     child: listResponse![0]['country'] == null
//                                         ? const Text("Loading data")
//                                         : Text(
//                                             "From : " +
//                                                 listResponse![0]['country']
//                                                     .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.white),
//                                           ),
//                                   ),
//                                 ),
//                                 //Contest Rating
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       top: 10, left: 10, right: 10),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(2)),
//                                   child: Center(
//                                     child: listResponse![0]['rating'] == null
//                                         ? const Text("Loading data")
//                                         : Text(
//                                             "Contest Rating : " +
//                                                 listResponse![0]['rating']
//                                                     .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.white),
//                                           ),
//                                   ),
//                                 ),
//                                 //MaxRating
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       top: 10, left: 10, right: 10),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(2)),
//                                   child: Center(
//                                     child: listResponse![0]['maxRating'] == null
//                                         ? const Text("Loading data")
//                                         : Text(
//                                             "Max Rating : " +
//                                                 listResponse![0]['maxRating']
//                                                     .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.white),
//                                           ),
//                                   ),
//                                 ),
//                                 //Current Rank
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       top: 10, left: 10, right: 10),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(2)),
//                                   child: Center(
//                                     child: listResponse![0]['rank'] == null
//                                         ? const Text("Loading data")
//                                         : Text(
//                                             "Current Rank : " +
//                                                 listResponse![0]['rank']
//                                                     .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.white),
//                                           ),
//                                   ),
//                                 ),
//                                 //Max Rank
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       top: 10, left: 10, right: 10, bottom: 10),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(2)),
//                                   child: Center(
//                                     child: listResponse![0]['maxRank'] == null
//                                         ? const Text("Loading data")
//                                         : Text(
//                                             "Max Rank : " +
//                                                 listResponse![0]['maxRank']
//                                                     .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.white),
//                                           ),
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Flexible(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     children: <Widget>[
//                       Text("$data",
//                           style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white)),
//                       //User contest List
//                       Container(
//                         margin: EdgeInsets.all(10),
//                         child: InkWell(
//                             borderRadius: BorderRadius.only(
//                                 // topLeft: Radius.circular(50.00),
//                                 bottomRight: Radius.circular(5.00)),
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => UserContestList(id: "",)));
//                             },
//                             child: Ink(
//                               height: MediaQuery.of(context).size.height / 15,
//                               width: MediaQuery.of(context).size.width - 20,
//                               decoration: BoxDecoration(
//                                   color: Colors.black12,
//                                   borderRadius: BorderRadius.only(
//                                     // topLeft: Radius.circular(50.00),
//                                     bottomRight: Radius.circular(5.00),
//                                   )),
//                               child: Container(
//                                   color: Colors.white12,
//                                   child: Center(
//                                       child: Row(
//                                     children: const [
//                                       Text("         "),
//                                       Icon(
//                                         Icons.account_tree_outlined,
//                                         size: 22,
//                                         color: Colors.white,
//                                       ),
//                                       Text("  User's Contest List",
//                                           style: TextStyle(
//                                               fontSize: 17.00,
//                                               color: Colors.white)),
//                                     ],
//                                   ))),
//                             )),
//                       ),
//                       //User Statistics
//                       Container(
//                         margin: EdgeInsets.all(10),
//                         color: Colors.white12,
//                         child: InkWell(
//                             borderRadius: BorderRadius.only(
//                                 // topLeft: Radius.circular(50.00),
//                                 bottomRight: Radius.circular(5.00)),
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const UserStatistics()));
//                             },
//                             child: Ink(
//                               height: MediaQuery.of(context).size.height / 15,
//                               width: MediaQuery.of(context).size.width - 20,
//                               decoration: BoxDecoration(
//                                   color: Colors.black12,
//                                   borderRadius: BorderRadius.only(
//                                     //  topLeft: Radius.circular(50.00),
//                                     bottomRight: Radius.circular(5.00),
//                                   )),
//                               child: Container(
//                                   child: Center(
//                                       child: Row(
//                                 children: const [
//                                   Text("         "),
//                                   Icon(
//                                     Icons.stacked_line_chart,
//                                     size: 22,
//                                     color: Colors.white,
//                                   ),
//                                   Text("  User's Statistics",
//                                       style: TextStyle(
//                                           fontSize: 17.00,
//                                           color: Colors.white)),
//                                 ],
//                               ))),
//                             )),
//                       ),
//                       //User Submissions
//                       Container(
//                         margin: EdgeInsets.all(10),
//                         color: Colors.white12,
//                         child: InkWell(
//                             borderRadius: BorderRadius.only(
//                                 //  topLeft: Radius.circular(50.00),
//                                 bottomRight: Radius.circular(5.00)),
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const UserSubmission()));
//                             },
//                             child: Ink(
//                               height: MediaQuery.of(context).size.height / 15,
//                               width: MediaQuery.of(context).size.width - 20,
//                               decoration: BoxDecoration(
//                                   color: Colors.black12,
//                                   borderRadius: BorderRadius.only(
//                                     //  topLeft: Radius.circular(50.00),
//                                     bottomRight: Radius.circular(5.00),
//                                   )),
//                               child: Container(
//                                   child: Center(
//                                       child: Row(
//                                 children: const [
//                                   Text("         "),
//                                   Icon(
//                                     Icons.app_registration,
//                                     size: 22,
//                                     color: Colors.white,
//                                   ),
//                                   Text("  User Submissions",
//                                       style: TextStyle(
//                                           fontSize: 17.00,
//                                           color: Colors.white)),
//                                 ],
//                               ))),
//                             )),
//                       ),
//                       //ContestList
//                       Container(
//                         margin: EdgeInsets.all(10),
//                         color: Colors.white12,
//                         child: InkWell(
//                             splashColor: Colors.green,
//                             borderRadius: BorderRadius.only(
//                                 //  topLeft: Radius.circular(50.00),
//                                 bottomRight: Radius.circular(5.00)),
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const ContestList()));
//                             },
//                             child: Ink(
//                               height: MediaQuery.of(context).size.height / 15,
//                               width: MediaQuery.of(context).size.width - 20,
//                               decoration: BoxDecoration(
//                                   color: Colors.black12,
//                                   borderRadius: BorderRadius.only(
//                                     // topLeft: Radius.circular(50.00),
//                                     bottomRight: Radius.circular(5.00),
//                                   )),
//                               child: Container(
//                                   child: Center(
//                                       child: Row(
//                                 children: const [
//                                   Text("         "),
//                                   Icon(
//                                     Icons.list_alt,
//                                     size: 22,
//                                     color: Colors.white,
//                                   ),
//                                   Text("  Contest List ",
//                                       style: TextStyle(
//                                           fontSize: 17.00,
//                                           color: Colors.white)),
//                                 ],
//                               ))),
//                             )),
//                       ),
//                       //Set Reminder
//                       Container(
//                         color: Colors.white12,
//                         margin: EdgeInsets.all(10),
//                         child: InkWell(
//                             borderRadius: BorderRadius.only(
//                                 //  topLeft: Radius.circular(50.00),
//                                 bottomRight: Radius.circular(5.00)),
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const SetReminder()));
//                             },
//                             child: Ink(
//                               height: MediaQuery.of(context).size.height / 15,
//                               width: MediaQuery.of(context).size.width - 20,
//                               decoration: BoxDecoration(
//                                   color: Colors.black12,
//                                   borderRadius: BorderRadius.only(
//                                     // topLeft: Radius.circular(50.00),
//                                     bottomRight: Radius.circular(5.00),
//                                   )),
//                               child: Container(
//                                   child: Center(
//                                       child: Row(
//                                 children: const [
//                                   Text("         "),
//                                   Icon(
//                                     Icons.access_alarm,
//                                     size: 22,
//                                     color: Colors.white,
//                                   ),
//                                   Text("  Set Reminder",
//                                       style: TextStyle(
//                                         fontSize: 17.00,
//                                         color: Colors.white,
//                                       )),
//                                 ],
//                               ))),
//                             )),
//                       ),
//                       //Top rated
//                       Container(
//                         margin: const EdgeInsets.all(10),
//                         color: Colors.white12,
//                         child: InkWell(
//                             borderRadius: const BorderRadius.only(
//                                 //topLeft: Radius.circular(50.00),
//                                 bottomRight: Radius.circular(5.00)),
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const TopRated()));
//                             },
//                             child: Ink(
//                               height: MediaQuery.of(context).size.height / 15,
//                               width: MediaQuery.of(context).size.width - 20,
//                               decoration: const BoxDecoration(
//                                   color: Colors.black12,
//                                   borderRadius: BorderRadius.only(
//                                     // topLeft: Radius.circular(50.00),
//                                     bottomRight: Radius.circular(5.00),
//                                   )),
//                               child: Center(
//                                   child: Row(
//                                 children: const [
//                                   Text("         "),
//                                   Icon(
//                                     Icons.arrow_upward_outlined,
//                                     size: 22,
//                                     color: Colors.white,
//                                   ),
//                                   Text("  Top 10 ",
//                                       style: TextStyle(
//                                         fontSize: 17.00,
//                                         color: Colors.white,
//                                       )),
//                                 ],
//                               )),
//                             )),
//                       ),
//
//                       Container(
//                         margin: const EdgeInsets.all(10),
//                         color: Colors.white12,
//                         child: InkWell(
//                             borderRadius: const BorderRadius.only(
//                                 //topLeft: Radius.circular(50.00),
//                                 bottomRight: Radius.circular(5.00)),
//                             onTap: () {
//                               _deletesharedData();
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const Checker()));
//                             },
//                             child: Ink(
//                               height: MediaQuery.of(context).size.height / 15,
//                               width: MediaQuery.of(context).size.width - 20,
//                               decoration: const BoxDecoration(
//                                   color: Colors.black12,
//                                   borderRadius: BorderRadius.only(
//                                     // topLeft: Radius.circular(50.00),
//                                     bottomRight: Radius.circular(5.00),
//                                   )),
//                               child: Center(
//                                   child: Row(
//                                 children: const [
//                                   Text("         "),
//                                   Icon(
//                                     Icons.arrow_upward_outlined,
//                                     size: 22,
//                                     color: Colors.white,
//                                   ),
//                                   Text("  Log out ",
//                                       style: TextStyle(
//                                         fontSize: 17.00,
//                                         color: Colors.white,
//                                       )),
//                                 ],
//                               )),
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//   }
// }
//
//



//flutter build apk --split-per-abi
Future<void> _deletesharedData() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.remove('handle');
}
