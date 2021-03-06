import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../notificationservice.dart';
class SetReminder extends StatefulWidget {
  const SetReminder({Key? key}) : super(key: key);
  @override
  State<SetReminder>createState()=>_SetReminderState();
}
List? listResponse;
Map? mapResponse;
String? lastContest = "";
int? time = -1;
int? Totalhours = -1;
double hours = -1;
double minutes = -1;
int days = 0;
int sec = 0;
int temp = 0;
double seconds = 0;
double rem1 = 0;
double rem2 = 0;
String? tempTime;

class _SetReminderState extends State<SetReminder>{

  final url = "https://codeforces.com/api/contest.list?gym=false";
  Future ApiCall() async{
    http.Response response;
    response = await http.get(Uri.parse(url));
    print("Status Code : ${response.statusCode}");

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
  int sec = 50;
  int period = 0;
  int h = 0;
  int m = 0;
  int s = 0;
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
        });
      }else{
        timer.cancel();
      }
    });
  }
  //call this ApiCall() method at first when u come to this page
  @override
  void initState() {
    //TODO: implement initState
    //code for timer
    tz.initializeTimeZones();
    ApiCall();
    startCountDown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text("Upcoming Contest"),
        backgroundColor: Colors.black12,
      ),
      body: ListView(
        children: [
          //Time remaining
          Container(
            margin: EdgeInsets.all(20),
              child: Center(
                child: Text("${h.toString()} : ${m.toString()} : ${s.toString()}",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                  ),
                ),
              )
          ),
          //Contest Name
          Container(
            padding: const EdgeInsets.all(15.00),
            margin: const EdgeInsets.all(15.00),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.00),
            ),
            child: Center(
                child: Text("$lastContest",
                    style: const TextStyle(
                        fontSize: 20.00,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold
                    ))
            ),
          ),
          //Set Reminder
          Container(
              margin: EdgeInsets.all(20),
              color: Colors.white12,
              child:  InkWell(
                splashColor: Colors.white,
              onTap: (){
                  print(sec);
                NotificationService().showNotification(1, "Codeforces Contest",
                    "Your Contest will start soon", sec.toInt());
                showDialog(context: context, builder: (context){
                  return AlertDialog(backgroundColor: Colors.black, title: const Text("Alarm has been set", style: TextStyle(color: Colors.white)), content: Text("You will be notified",style: TextStyle(color: Colors.white)),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text("ok",style: TextStyle(color: Colors.white))),
                    ],
                  );
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.00),
                  color: Colors.black12,
                ),
                child: Container(
                  margin: const EdgeInsets.all(15.00),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Set Reminder ",
                            style: TextStyle(fontSize: 17.00, color: Colors.white)),
                        Icon(
                            Icons.alarm,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),

            )
          ),

        ],
      )
    );
  }
}
