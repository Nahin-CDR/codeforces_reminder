import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class UserStatistics extends StatefulWidget {

  final String id;
  UserStatistics({
    Key? key,
    required this.id,
  }) : super(key: key);


  @override
  State<UserStatistics> createState() =>_UserStatisticsState(userHandle: id);
}
//String userName = "Nahin_junior71";
String problemCount = "50";

List? listResponse;
Map? mapResponse;
Map? accepted;
String? acLen = "-1";
String? totalAttempted = "-1";
String? total_rejected = "-1";

Map? ContestCountmp;
List? ContestCountList;

String? count800 = "0";
String? count900 = "0";
String? count1000 = "0";
String? count1100 = "0";
String? count1200 = "0";
String? count1300 = "0";
String? count1400 = "0";
String? count1500 = "0";
String? count1600 = "0";
String? count1700 = "0";
String? count1800 = "0";
String? count1900 = "0";
String? count2200 = "0";
String? contestCount = "0";

class _UserStatisticsState extends State<UserStatistics> {

  String userHandle;
  _UserStatisticsState({required this.userHandle});
  get ID => userHandle.toString();





  // final url = ;//&from=1&count=$problemCount";
  // final url2 = ; //contest List

  Future ApiCall() async{
    http.Response response1,response2;
    response1 = await http.get(Uri.parse("https://codeforces.com/api/user.status?handle=$userHandle"));
    response2 = await http.get(Uri.parse("https://codeforces.com/api/user.rating?handle=$userHandle"));


    print(response1.statusCode);
    if(response1.statusCode == 200){
      setState(() {
        mapResponse = json.decode(response1.body);
        listResponse = mapResponse!['result'];
        Set<String>uniqueCountAC = Set();
        Set<String>uniqueCountTotal = Set();

        Set<String>Rating_800 = Set();
        Set<String>Rating_900 = Set();
        Set<String>Rating_1000 = Set();
        Set<String>Rating_1100 = Set();
        Set<String>Rating_1200 = Set();
        Set<String>Rating_1300 = Set();
        Set<String>Rating_1400 = Set();
        Set<String>Rating_1500 = Set();
        Set<String>Rating_1600 = Set();
        Set<String>Rating_1700 = Set();
        Set<String>Rating_1800 = Set();
        Set<String>Rating_1900 = Set();
        Set<String>Rating_2200 = Set();


        listResponse?.forEach((element) {

          if(element['verdict'].toString() == "OK" ){
              String temp = element['problem']['contestId'].toString() + element['problem']['name'].toString();
              uniqueCountAC.add(temp);
              uniqueCountTotal.add(temp);

              if(element['problem']['rating'].toString() == "800"){
                Rating_800.add(temp);
              }
              if(element['problem']['rating'].toString() == "900"){
                Rating_900.add(temp);
              }
              if(element['problem']['rating'].toString() == "1000"){
                Rating_1000.add(temp);
              }
              if(element['problem']['rating'].toString() == "1100"){
                Rating_1100.add(temp);
              }
              if(element['problem']['rating'].toString() == "1200"){
                Rating_1200.add(temp);
              }
              if(element['problem']['rating'].toString() == "1300"){
                Rating_1300.add(temp);
              }
              if(element['problem']['rating'].toString() == "1400"){
                Rating_1400.add(temp);
              }
              if(element['problem']['rating'].toString() == "1500"){
                Rating_1500.add(temp);
              }
              if(element['problem']['rating'].toString() == "1600"){
                Rating_1600.add(temp);
              }
              if(element['problem']['rating'].toString() == "1700"){
                Rating_1700.add(temp);
              }
              if(element['problem']['rating'].toString() == "1800"){
                Rating_1800.add(temp);
              }
              if(element['problem']['rating'].toString() == "1900"){
                Rating_1900.add(temp);
              }
              if(element['problem']['rating'].toString() == "2200"){
                Rating_2200.add(temp);
              }
          }else{
            String temp = element['problem']['contestId'].toString() + element['problem']['name'].toString();
            uniqueCountTotal.add(temp);
          }
        });

      int ac = uniqueCountAC.length;
      count800 = Rating_800.length.toString();
      count900 = Rating_900.length.toString();
      count1000 = Rating_1000.length.toString();
      count1100 = Rating_1100.length.toString();
      count1200 = Rating_1200.length.toString();
      count1300 = Rating_1300.length.toString();
      count1400 = Rating_1400.length.toString();
      count1500 = Rating_1500.length.toString();
      count1600 = Rating_1600.length.toString();
      count1700 = Rating_1700.length.toString();
      count1800 = Rating_1800.length.toString();
      count1900 = Rating_1900.length.toString();
      count2200 = Rating_2200.length.toString();
      acLen = uniqueCountAC.length.toString();
      int total_attempted = uniqueCountTotal.length;
      int rejected = total_attempted-ac;
      totalAttempted = total_attempted.toString();
      total_rejected = rejected.toString();
      });
    }else{
      print("Error");
    }

    Set<String>number_of_contest = Set();
    if(response2.statusCode == 200){
      setState(() {
        ContestCountmp = json.decode(response2.body);
        ContestCountList = ContestCountmp!['result'];

        ContestCountList?.forEach((element) {
            String temp = element['contestName'].toString();
            number_of_contest.add(temp);
        });

      });
    }
    contestCount = number_of_contest.length.toString();


  }
  //call this ApiCall() method at first when u come to this page




  @override
  void initState() {
    // TODO: implement initState
    ApiCall();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text("User Statistics"),
        backgroundColor: Colors.black12,
      ),
      body: ListView(
       children: [
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
                 borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(5.00),
                   topRight: Radius.circular(5.00),
                 ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     Text("         "),
                     Container(
                       child: acLen != "-1"?Text("Total Attempted : "+totalAttempted.toString()
                         ,style: TextStyle(
                           fontSize: 15.00,
                           color: Colors.white
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(5.00),
                 topRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("Total Contest : "+contestCount.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                           color: Colors.white,
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(5.00),
                 topRight: Radius.circular(5.00),
               ),
               color: Colors.green,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text( " Accepted : "+acLen.toString()
                         ,style:const TextStyle(
                           fontSize: 15.00,
                           color: Colors.white
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(5.00),
                 topRight: Radius.circular(5.00),
               ),
               color: Colors.red,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"? Text("  Wrong Ans : "+total_rejected.toString(),
                         style: TextStyle(fontSize: 15.00, color: Colors.white),)
                           :const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),

         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.brown,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: Text("Solve count according to rating ",
                         style: TextStyle(fontSize: 15.00, color: Colors.white)),
                     )
                   ],
                 )
             )
         ),
         //Rating 800
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("800 rating : "+count800.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                             color: Colors.white
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 900
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("900 rating : "+count900.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                             color: Colors.white,
                         ),
                       ): const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 1000
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                    const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("1000 rating : "+count1000.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                           color: Colors.white,
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 1100
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
                 color: Colors.white12
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("1100 rating : "+count1100.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                             color: Colors.white
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 1200
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("1200 rating : "+count1200.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                             color: Colors.white,
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 1300
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("1300 rating : "+count1300.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                             color: Colors.white
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 1400
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("1400 rating : "+count1400.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                           color: Colors.white,
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 1500
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("1500 rating : "+count1500.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                           color: Colors.white,
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 1600
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("1600 rating : "+count1600.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                           color: Colors.white,
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 1700
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"? Text("1700 rating : "+count1700.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                           color: Colors.white,
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 1800
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("1800 rating : "+count1800.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                             color: Colors.white,
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 1900
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("1900 rating : "+count1900.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                           color: Colors.white,
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),
         //Rating 2200
         Container(
             height: 45,
             width: MediaQuery.of(context).size.width-20,
             margin: const EdgeInsets.all(10.00),
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(5.00),
                 bottomRight: Radius.circular(5.00),
               ),
               color: Colors.white12,
             ),
             child: Center(
                 child : Row(
                   children: [
                     const Text("         "),
                     Container(
                       child: acLen != "-1"?Text("2200 rating : "+count2200.toString()
                         ,style: const TextStyle(
                           fontSize: 15.00,
                           color: Colors.white,
                         ),
                       ):const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                     )
                   ],
                 )
             )
         ),






       ],
      )
    );
  }
}
