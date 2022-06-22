import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:codeforces_reminder/codeforces/graph.dart';
import 'package:codeforces_reminder/codeforces/set_reminder.dart';
import 'package:codeforces_reminder/codeforces/user_stats.dart';
import 'package:flutter/physics.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../notificationservice.dart';
import 'package:codeforces_reminder/checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'codeforces/contest_list.dart';
import 'codeforces/top_rated.dart';
import 'codeforces/user_contest_list.dart';
import 'codeforces/user_statistics.dart';
import 'codeforces/user_submission.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
final Uri toLaunch = Uri(scheme: 'https', host: 'nahindcoder.blogspot.com');

class MENUS extends StatefulWidget {
  @override
  State<MENUS> createState() => _MENUSState();
}

List? listResponse2;
Map? mapResponse2;

List? listResponse1;
Map? mapResponse1;

List? listResponseContest;
Map? mapResponseContest;


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

int? rank = 0;

// variable for rating data

int count800 = 100;
int count900 = 0;
int count1000 = 0;
int count1100 = 0;
int count1200 = 0;
int count1300 = 0;
int count1400 = 0;
int count1500 = 0;
int count1600 = 0;
int count1700 = 0;
int count1800 = 0;
int count1900 = 0;
int count2200 = 0;
int count2300 = 0;
int count2400 = 0;
int count2500 = 0;
int count2600 = 0;
int count2700 = 0;
int count2800 = 0;
int count2900 = 0;
int count3000 = 0;
int count3100 = 0;
int count3200 = 0;
int count3300 = 0;
int count3400 = 0;
int count3500 = 0;
int count3600 = 0;
int count3700 = 0;
int count3800 = 0;
int count3900 = 0;
int count4000 = 0;













class _MENUSState extends State<MENUS> {

  //get data from shared pref and set the handle name
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
    if(response.statusCode == 200){
      setState(() {
        mapResponseContest = json.decode(response.body);
        listResponseContest = mapResponseContest!['result'];
        listResponseContest?.forEach((element) {
          if(element['phase'].toString() == "BEFORE"){
            tempTime = element['relativeTimeSeconds'].toString();
            lastContest = element['name'].toString();
            // print(tempTime);
          }});
      });
    }
    time = int.parse(tempTime!);
    time = time!*(-1);
    sec = time!;
   // setState(() {_loading = false;});
  }
  // int sec = 150;
  int period = 0;
  void startCountDown(){
    Timer.periodic(const Duration(seconds:1), (timer) {
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
        });
      }else{
        timer.cancel();
      }
    });
  }

  Future ApiCall() async {

    http.Response response1,response2;
    response1 = await http.get(Uri.parse("https://codeforces.com/api/user.status?handle=$data"));

    //Chart Data;
    if(response1.statusCode == 200){
      setState(() {
        mapResponse1 = json.decode(response1.body);
        listResponse1 = mapResponse1!['result'];
        Set<String>uniqueCountAC = Set();
        Set<String>uniqueCountTotal = Set();
        Set<String>Rating800 = Set();
        Set<String>Rating900 = Set();
        Set<String>Rating1000 = Set();
        Set<String>Rating1100 = Set();
        Set<String>Rating1200 = Set();
        Set<String>Rating1300 = Set();
        Set<String>Rating1400 = Set();
        Set<String>Rating1500 = Set();
        Set<String>Rating1600 = Set();
        Set<String>Rating1700 = Set();
        Set<String>Rating1800 = Set();
        Set<String>Rating1900 = Set();
        Set<String>Rating2200 = Set();
        Set<String>Rating2300 = Set();
        Set<String>Rating2400 = Set();
        Set<String>Rating2500 = Set();
        Set<String>Rating2600 = Set();
        Set<String>Rating2700 = Set();
        Set<String>Rating2800 = Set();
        Set<String>Rating2900 = Set();
        Set<String>Rating3000 = Set();
        Set<String>Rating3100 = Set();
        Set<String>Rating3200 = Set();
        Set<String>Rating3300 = Set();
        Set<String>Rating3400 = Set();
        Set<String>Rating3500 = Set();
        Set<String>Rating3600 = Set();
        Set<String>Rating3700 = Set();
        Set<String>Rating3800 = Set();
        Set<String>Rating3900 = Set();
        Set<String>Rating4000 = Set();


        listResponse1?.forEach((element) {
          if(element['verdict'].toString() == "OK" ){
            String temp = element['problem']['contestId'].toString()+element['problem']['name'].toString()+element['problem']['rating'].toString()+ element['problem']['index'].toString();

            uniqueCountAC.add(temp);
            uniqueCountTotal.add(temp);

            if(element['problem']['rating'].toString() == "800"){
              Rating800.add(temp);
            }
            if(element['problem']['rating'].toString() == "900"){
              Rating900.add(temp);
            }
            if(element['problem']['rating'].toString() == "1000"){
              Rating1000.add(temp);
            }
            if(element['problem']['rating'].toString() == "1100"){
              Rating1100.add(temp);
            }
            if(element['problem']['rating'].toString() == "1200"){
              Rating1200.add(temp);
            }
            if(element['problem']['rating'].toString() == "1300"){
              Rating1300.add(temp);
            }
            if(element['problem']['rating'].toString() == "1400"){
              Rating1400.add(temp);
            }
            if(element['problem']['rating'].toString() == "1500"){
              Rating1500.add(temp);
            }
            if(element['problem']['rating'].toString() == "1600"){
              Rating1600.add(temp);
            }
            if(element['problem']['rating'].toString() == "1700"){
              Rating1700.add(temp);
            }
            if(element['problem']['rating'].toString() == "1800"){
              Rating1800.add(temp);
            }
            if(element['problem']['rating'].toString() == "1900"){
              Rating1900.add(temp);
            }
            if(element['problem']['rating'].toString() == "2200"){
              Rating2200.add(temp);
            }
            if(element['problem']['rating'].toString() == "2300"){
              Rating2300.add(temp);
            }
            if(element['problem']['rating'].toString() == "2400"){
              Rating2400.add(temp);
            }
            if(element['problem']['rating'].toString() == "2500"){
              Rating2500.add(temp);
            }
            if(element['problem']['rating'].toString() == "2600"){
              Rating2600.add(temp);
            }
            if(element['problem']['rating'].toString() == "2700"){
              Rating2700.add(temp);
            }
            if(element['problem']['rating'].toString() == "2800"){
              Rating2800.add(temp);
            }
            if(element['problem']['rating'].toString() == "2900"){
              Rating2900.add(temp);
            }
            if(element['problem']['rating'].toString() == "3000"){
              Rating3000.add(temp);
            }
            if(element['problem']['rating'].toString() == "3100"){
              Rating3100.add(temp);
            }
            if(element['problem']['rating'].toString() == "3200"){
              Rating3200.add(temp);
            }
            if(element['problem']['rating'].toString() == "3300"){
              Rating2300.add(temp);
            }
            if(element['problem']['rating'].toString() == "3400"){
              Rating3400.add(temp);
            }
            if(element['problem']['rating'].toString() == "3500"){
              Rating3500.add(temp);
            }
            if(element['problem']['rating'].toString() == "3600"){
              Rating3600.add(temp);
            }
            if(element['problem']['rating'].toString() == "3700"){
              Rating3700.add(temp);
            }
            if(element['problem']['rating'].toString() == "3800"){
              Rating3800.add(temp);
            }
            if(element['problem']['rating'].toString() == "3900"){
              Rating3900.add(temp);
            }
            if(element['problem']['rating'].toString() == "4000"){
              Rating4000.add(temp);
            }

          }else{
            String temp = element['problem']['contestId'].toString()+element['problem']['name'].toString()+element['problem']['rating'].toString()+ element['problem']['index'].toString();
            uniqueCountTotal.add(temp);
          }
        });

        count800 = Rating800.length;
        count900 = Rating900.length;
        count1000 = Rating1000.length;
        count1100 = Rating1100.length;
        count1200 = Rating1200.length;
        count1300 = Rating1300.length;
        count1400 = Rating1400.length;
        count1500 = Rating1500.length;
        count1600 = Rating1600.length;
        count1700 = Rating1700.length;
        count1800 = Rating1800.length;
        count1900 = Rating1900.length;
        count2200 = Rating2200.length;
        count2300 = Rating2300.length;
        count2400 = Rating2400.length;
        count2500 = Rating2500.length;
        count2600 = Rating2600.length;
        count2700 = Rating2700.length;
        count2800 = Rating2800.length;
        count2900 = Rating2900.length;
        count3000 = Rating3000.length;
        count3100 = Rating3100.length;
        count3200 = Rating3200.length;
        count3300 = Rating3300.length;
        count3400 = Rating3400.length;
        count3500 = Rating3500.length;
        count3600 = Rating3600.length;
        count3700 = Rating3700.length;
        count3800 = Rating3800.length;
        count3900 = Rating3900.length;
        count4000 = Rating4000.length;


      });

    }

    response2 = await http.get(Uri.parse("https://codeforces.com/api/user.info?handles=$data"));

    if (response2.statusCode == 200) {
      setState(() {
        mapResponse2 = json.decode(response2.body);
        listResponse2 = mapResponse2!['result'];
      });
      setState(() {
        rank = listResponse2![0]['rating'] as int;
      });
    }


    setState(() {_loading = false;});
  }



  @override
  initState() {
    _sharedData();
    ApiCall_For_upcomingContest();
    tz.initializeTimeZones();
    startCountDown();
    super.initState();
    setState((){
      _loading = true;
    });
    Timer(const Duration(seconds: 5), () {
      ApiCall();
    });
    //if server takes too much time to respond
    Timer(const Duration(seconds: 30), () {
      if(_loading == true) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.blueGrey,
                title: const Text("Sorry!", style: TextStyle(color: Colors.white)),
                content: const Text("I'm unable to show data,server is not responding..",style: TextStyle(color: Colors.white)),
                actions: <Widget>[
                  TextButton(
                    child: const Text('exit',style: TextStyle(color: Colors.white)),
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
      body:  MyMenus(), //MyMenus(),
    );
  }
}

class MyMenus extends StatelessWidget {
  const MyMenus({Key? key}) : super(key: key);

  //launching portfolio site
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,

    )) {
      throw 'Could not launch $url';
    }
  }

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
                margin: const EdgeInsets.only(top:5,left: 10,right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient:  LinearGradient(
                    colors: [
                      const Color.fromRGBO(32, 50, 93, 0.5),
                      const Color.fromRGBO(32, 50, 93, 0.5),
                      Colors.grey,
                      rank! >= 2400 ?Colors.red
                          :
                      (rank!<2400 && rank!>=2200)?Colors.orange
                          :
                      (rank!<2200 && rank!>=1900)?const Color.fromRGBO(169, 20, 167, 1.0)
                          :
                      (rank!<1900 && rank!>=1600)?const Color.fromRGBO(0, 38,249, 1.0)
                          :
                      (rank!<1600 && rank!>=1400)?const Color.fromRGBO(34,175,166, 1.0)
                          :
                      (rank!<1600 && rank!>=1400)?const Color.fromRGBO(13,127,25, 1.0)
                          :
                      Colors.grey

                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 0.2, 0.8, 1],
                  ),
                 // color: Color.fromRGBO(32, 50, 93, 0.5),
                )
            ),
                  //color:const Color.fromRGBO(32, 50, 93, 2.0))),
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
                child: Text("upcoming contest : ",
                    style: TextStyle(
                        fontSize: 15.00,
                        color: Colors.white, fontWeight: FontWeight.bold))
            ),
            //show dialog for watching upcoming contest name
            Positioned(
              top: 145,
              right: 20,
              child: IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      backgroundColor: const Color.fromRGBO(32, 50, 93, 1.0),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:const [
                          Text("Upcoming Contest",style: TextStyle(color: Colors.white)),
                          Divider(color: Colors.white,thickness: 2,)
                        ],
                      ),
                      content:  Text("$lastContest",style: const TextStyle(fontSize: 15.00,color: Colors.white)),
                      actions: [
                        TextButton(onPressed: ()=>Navigator.of(context).pop(),child: const Text("ok",style: TextStyle(color: Colors.white),))
                      ],
                    );
                  });
                },
                icon:const Icon(FontAwesomeIcons.arrowsToEye,color: Colors.white,),
              ),
            ),
            //name
            Positioned(
                top: 15,
                left: 20,
                child:listResponse2![0]['firstName'] == null ?const Text("name not found...",style: TextStyle(fontSize: 12,color: Colors.blue))
                    :Text("Name : "+listResponse2![0]['firstName'].toString(),style: const TextStyle( fontSize: 15.00, color: Colors.white))
            ),
            //country
            Positioned(
              top: 35,
              left: 20,
              child: listResponse2![0]['country'] == null? const Text("country not found...",style: TextStyle(fontSize: 12,color: Colors.blue))
                  :Text("From : "+listResponse2![0]['country'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white)),
            ),
            //contest rating
            Positioned(
              top: 55,
              left: 20,
              child: listResponse2![0]['rating'] ==null?const Text("contest rating not found...",style: TextStyle(fontSize: 12,color: Colors.blue)) :
              Text("Contest Rating : "+listResponse2![0]['rating'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white)),
            ),
            //max rating
            Positioned(
              top: 75,
              left: 20,
              child: listResponse2![0]['maxRating'] == null?const Text("max rating not found...",style: TextStyle(fontSize: 12,color: Colors.blue)) :
              Text("Max Rating : "+listResponse2![0]['maxRating'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white),),
            ),
            //current rank
            Positioned(
              top: 95, left: 20,
              child: listResponse2![0]['rank'] == null?const Text("current rank not found...",style: TextStyle(fontSize: 12,color: Colors.blue)) :
              Text("Current Rank : "+listResponse2![0]['rank'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white)),),
            //max rank
            Positioned(
              top: 115,
              left: 20,
              child: listResponse2![0]['maxRank'] == null ? const Text("max rank not found...",style: TextStyle(fontSize: 12,color: Colors.blue)) : Text("Max Rank : "+listResponse2![0]['maxRank'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white),),
            ),
            //profile image
            Positioned(
              top: 190,
              child: Container(
                height: 110,
                width: 120,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.white,
                      Colors.white,
                    ]),
                    shape: BoxShape.circle),
                child: Padding(
                  //this padding will be you border size
                  padding: const EdgeInsets.all(2.5),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      //foregroundImage: NetworkImage("https://i.ibb.co/rkG8cCs/112921315-gettyimages-876284806.jpg"),
                      backgroundImage: NetworkImage(listResponse2![0]['titlePhoto'].toString()),


                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        //handle
        Container(
         // height: 50,
          // decoration: BoxDecoration(
          //   color: Colors.white70,
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          margin:const EdgeInsets.only(top:55,left: 15,right: 15),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text("${data?.substring(0,1)}",
                     style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                     color: rank! >= 2900 ?Colors.grey
                         :
                     (rank!<2900 && rank!>=2400)?Colors.red
                         :
                     (rank!<2400 && rank!>=2200)?Colors.orange
                         :
                     (rank!<2200 && rank!>=1900)?const Color.fromRGBO(169, 20, 167, 1.0)
                         :
                     (rank!<1900 && rank!>=1600)?const Color.fromRGBO(0, 38,249, 1.0)
                         :
                     (rank!<1600 && rank!>=1400)?const Color.fromRGBO(34,175,166, 1.0)
                         :
                       (rank!<1600 && rank!>=1400)?const Color.fromRGBO(13,127,25, 1.0)
                           :
                       Colors.grey
                     )),Text("${data?.substring(1,data?.length)}",
                     style:
                     TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                         color:
                         rank! >= 2400 ?Colors.red
                             :
                         (rank!<2400 && rank!>=2200)?Colors.orange
                             :
                         (rank!<2200 && rank!>=1900)?const Color.fromRGBO(169, 20, 167, 1.0)
                             :
                         (rank!<1900 && rank!>=1600)?const Color.fromRGBO(0, 38,249, 1.0)
                             :
                         (rank!<1600 && rank!>=1400)?const Color.fromRGBO(34,175,166, 1.0)
                             :
                         (rank!<1600 && rank!>=1400)?const Color.fromRGBO(13,127,25, 1.0)
                             :
                         Colors.grey
                     )
                 )
                ],
              ),
          ),
        ),

        Container(
          margin:const EdgeInsets.only(top: 8,left: 15,right: 15,bottom: 5),
          child: const Divider(color: Colors.white,thickness: 2),
        ),

        //main section
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          margin: const EdgeInsets.only(top:20.00,left:10,right:10,bottom: 10),
         // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color:const Color.fromRGBO(32, 50, 93, 0.5),
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [
                rank! >= 2400 ?Colors.red
                    :
                (rank!<2400 && rank!>=2200)?Colors.orange
                    :
                (rank!<2200 && rank!>=1900)?const Color.fromRGBO(169, 20, 167, 1.0)
                    :
                (rank!<1900 && rank!>=1600)?const Color.fromRGBO(0, 38,249, 1.0)
                    :
                (rank!<1600 && rank!>=1400)?const Color.fromRGBO(34,175,166, 1.0)
                    :
                (rank!<1600 && rank!>=1400)?const Color.fromRGBO(13,127,25, 1.0)
                    :
                Colors.grey,
                //Colors.red,
                Colors.grey,
                const Color.fromRGBO(32, 50, 93, 0.5),
                const Color.fromRGBO(32, 50, 93, 0.5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.2, 0.8, 1],
            ),
          ),
          child:   Column(
            children: [
              //User contest List
              Container(
                margin:const EdgeInsets.only(top: 10,left: 15,right: 15),
                // decoration: BoxDecoration(
                //     gradient:const LinearGradient(colors: [
                //       Colors.transparent,
                //       Colors.transparent,
                //       Colors.transparent,
                //       Colors.transparent,
                //       Colors.black,
                //     ]),
                //   borderRadius: BorderRadius.circular(5)
                // ),
                child: InkWell(
                    borderRadius:BorderRadius.circular(8.00),
                    onTap: () async {
                      try {
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) { //checking if network is connected
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sync...",style: TextStyle(fontSize: 12.00, color: Colors.white),),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: Colors.green,
                          ));
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              UserContestList(id:data.toString())));

                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          // const SetReminder()
                          // ));

                        }
                      }on SocketException catch (_) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                      }
                    },
                    child: Ink(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8.0)
                        // borderRadius: BorderRadius.only(
                        //   // topLeft: Radius.circular(50.00),
                        //   bottomRight: Radius.circular(15.00),
                        // )
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            //color: Colors.white12
                          ),
                          //color: Colors.white12,
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                    flex: 1,
                                    child:  Icon(Icons.account_tree_outlined,size: 18,color: Colors.white),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child:  Text("User's Contest List", style: TextStyle(fontSize: 15.00,color: Colors.white)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child:  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,),
                                  ),
                                ],
                              ))),
                    )),
              ),
              //User Statistics
              Container(
                margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: InkWell(
                    borderRadius:BorderRadius.circular(8.00),
                    onTap: () async {
                      try {
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) { //checking if network is connected
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sync...",style: TextStyle(fontSize: 12.00, color: Colors.white),),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: Colors.green,
                          ));


                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              UserStats(id:data.toString() ,
                                count800: count800.toInt(),
                                count900: count900.toInt(),
                                count1000: count1000.toInt(),
                                count1100: count1100.toInt(),
                                count1200 : count1200.toInt(),
                                count1300 : count1300.toInt(),
                                count1400 : count1400.toInt(),
                                count1500 : count1500.toInt(),
                                count1600 : count1600.toInt(),
                                count1700 : count1700.toInt(),
                                count1800 : count1800.toInt(),
                                count1900 : count1900.toInt(),
                                count2200:count2200.toInt(),
                                count2300:count2300.toInt(),
                                count2400:count2400.toInt(),
                                count2500:count2500.toInt(),
                                count2600:count2600.toInt(),
                                count2700:count2700.toInt(),
                                count2800:count2800.toInt(),
                                count2900:count2900.toInt(),
                                count3000:count3000.toInt(),
                                count3100:count3100.toInt(),
                                count3200:count3200.toInt(),
                                count3300:count3300.toInt(),
                                count3400:count3400.toInt(),
                                count3500:count3500.toInt(),
                                count3600:count3600.toInt(),
                                count3700:count3700.toInt(),
                                count3800:count3800.toInt(),
                                count3900:count3900.toInt(),
                                count4000:count4000.toInt(),
                              )));

                        }
                      }on SocketException catch (_) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                      }
                    },
                    child: Ink(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8.0)
                        // borderRadius: BorderRadius.only(
                        //   // topLeft: Radius.circular(50.00),
                        //   bottomRight: Radius.circular(15.00),
                        // )
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          //color: Colors.white12,
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                      flex: 1,
                                      child:Icon(
                                          Icons.stacked_line_chart,
                                          size: 18,
                                          color: Colors.white
                                      )
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child:  Text("User's Statistics", style: TextStyle(fontSize: 15.00,color: Colors.white)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child:  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,),
                                  ),
                                ],
                              ))),
                    )),
              ),
              //User Submissions
              Container(
                margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: InkWell(
                    borderRadius:BorderRadius.circular(8.00),
                    onTap: () async {
                      try {
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) { //checking if network is connected
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sync...",style: TextStyle(fontSize: 12.00, color: Colors.white),),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: Colors.green,
                          ));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserSubmission(id:data.toString())));
                        }
                      }on SocketException catch (_) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                      }
                    },
                    child: Ink(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8.0)
                        // borderRadius: BorderRadius.only(
                        //   // topLeft: Radius.circular(50.00),
                        //   bottomRight: Radius.circular(15.00),
                        // )
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          //color: Colors.white12,
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                      flex: 1,

                                      child:Icon(
                                          Icons.app_registration,
                                          size: 18,
                                          color: Colors.white
                                      )
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child:  Text("User's Submissions", style: TextStyle(fontSize: 15.00,color: Colors.white)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child:  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,),
                                  ),
                                ],
                              ))),
                    )),
              ),
              //ContestList
              Container(
                margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: InkWell(
                    borderRadius:BorderRadius.circular(8.00),
                    onTap: () async {
                      try {
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) { //checking if network is connected
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sync...",style: TextStyle(fontSize: 12.00, color: Colors.white),),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: Colors.green,
                          ));
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>const ContestList()));
                        }
                      }on SocketException catch (_) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                      }
                    },
                    child: Ink(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8.0)
                        // borderRadius: BorderRadius.only(
                        //   // topLeft: Radius.circular(50.00),
                        //   bottomRight: Radius.circular(15.00),
                        // )
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          //color: Colors.white12,
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                      flex: 1,
                                      child:Icon(
                                          Icons.list_alt,
                                          size: 18,
                                          color: Colors.white
                                      )
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child:  Text("Contest List", style: TextStyle(fontSize: 15.00,color: Colors.white)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child:  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,),
                                  ),
                                ],
                              ))),
                    )),
              ),
              //Top rated
              Container(
                margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: InkWell(
                    borderRadius:BorderRadius.circular(8.00),
                    onTap: () async {
                      try {
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) { //checking if network is connected
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sync...",style: TextStyle(fontSize: 12.00, color: Colors.white),),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: Colors.green,
                          ));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const TopRated()));
                        }
                      }on SocketException catch (_) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                      }
                    },
                    child: Ink(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8.0)
                        // borderRadius: BorderRadius.only(
                        //   // topLeft: Radius.circular(50.00),
                        //   bottomRight: Radius.circular(15.00),
                        // )
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          //color: Colors.white12,
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                      flex: 1,

                                      child:Icon(
                                          Icons.arrow_upward_outlined,
                                          size: 18,
                                          color: Colors.white
                                      )
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child:  Text("Top Rated", style: TextStyle(fontSize: 15.00,color: Colors.white)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child:  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,),
                                  ),
                                ],
                              ))),
                    )),
              ),
              //log out
              Container(
                margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: InkWell(
                    borderRadius:BorderRadius.circular(8.00),
                    onTap: () async{
                      _deletesharedData();

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Checker()));
                    },
                    child: Ink(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8.0)
                        // borderRadius: BorderRadius.only(
                        //   // topLeft: Radius.circular(50.00),
                        //   bottomRight: Radius.circular(15.00),
                        // )
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          //color: Colors.white12,
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                      flex: 1,

                                      child:Icon(
                                          Icons.logout,
                                          size: 18,
                                          color: Colors.white
                                      )
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child:  Text("Logout", style: TextStyle(fontSize: 15.00,color: Colors.white)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child:  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,),
                                  ),
                                ],
                              ))),
                    )),
              ),
              //Set Reminder
              Container(
                margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: InkWell(
                    borderRadius:BorderRadius.circular(8.00),
                    onTap: ()async {
                      int limit = sec.toInt();
                      if(limit-60>0){
                        limit = limit - 60; //alarm will ring before 60 seconds of contest
                      }
                      NotificationService().showNotification(1, "Codeforces Contest","Your Contest will start soon",limit);
                      showDialog(barrierDismissible: false, context: context, builder: (context){
                        return AlertDialog(
                          backgroundColor: const Color.fromRGBO(32, 50, 93, 1.0),
                        title:  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text("Alarm has been set for $lastContest ", style:const TextStyle(color: Colors.white,fontSize: 18)),
                            Divider(color: Colors.white,thickness: 2,)
                          ],
                        ),
                        content:const Text("You will be notified !",style: TextStyle(color: Colors.white)),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: const Text("ok",style: TextStyle(color: Colors.white))),
                        ],
                      );
                      });
                    },
                    child: Ink(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          //color: Colors.white12,
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                      flex: 1,

                                      child:Icon(
                                          Icons.access_alarm,
                                          size: 18,
                                          color: Colors.white
                                      )
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child:  Text("Set Reminder", style: TextStyle(fontSize: 15.00,color: Colors.white)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child:  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,),
                                  ),
                                ],
                              ))),
                    )),
              ),


            ],
          ),
        ),

        const SizedBox(height: 10),
        Row(
          children: [
            //developer
            Flexible(
                flex: 1,
                child:  Center(
                  child: TextButton(
                    onPressed: () async {

                      try {
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                          _launchInBrowser(toLaunch);
                        }
                      } on SocketException catch (_) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                      }

                    },
                    child:const Text("--- Developer ---",style: TextStyle(color: Colors.white,fontSize: 15),),
                  ),
                ),

            ),
            //review this app
            Flexible(
                flex: 1,
                child:  Center(
                  child: TextButton(
                    onPressed: ()async {
                      try {
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                          LaunchReview.launch(
                            androidAppId: "com.codeforces_reminder_nahindcoder.codeforces_reminder",
                          );
                        }
                      } on SocketException catch (_) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet...", style: TextStyle(fontSize: 12.00, color: Colors.white),), duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,));
                      }

                    },
                    child:const Text("--- Review App ---",style: TextStyle(color: Colors.white,fontSize: 15),),
                  ),
                ),

            )
          ],
        ),

        const SizedBox(height: 10),


      ],
    );
  }
}



Future<void> _deletesharedData() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.remove('handle');
}

//Lowest API capacity 25