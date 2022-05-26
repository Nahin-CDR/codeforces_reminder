import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
String? count2300 = "0";
String? count2400 = "0";
String? count2500 = "0";
String? count2600 = "0";
String? count2700 = "0";
String? count2800 = "0";
String? count2900 = "0";
String? count3000 = "0";
String? count3100 = "0";
String? count3200 = "0";
String? count3300 = "0";
String? count3400 = "0";
String? count3500 = "0";
String? count3600 = "0";
String? count3700 = "0";
String? count3800 = "0";
String? count3900 = "0";
String? count4000 = "0";

int bestRank = 999999999;
int worstRank = 0;
int maxUp = 0;
int maxDown = 999999999;



String? contestCount = "0";
double? width;
bool _isLoading = true;
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
        Set<String>Rating_2300 = Set();
        Set<String>Rating_2400 = Set();
        Set<String>Rating_2500 = Set();
        Set<String>Rating_2600 = Set();
        Set<String>Rating_2700 = Set();
        Set<String>Rating_2800 = Set();
        Set<String>Rating_2900 = Set();
        Set<String>Rating_3000 = Set();
        Set<String>Rating_3100 = Set();
        Set<String>Rating_3200 = Set();
        Set<String>Rating_3300 = Set();
        Set<String>Rating_3400 = Set();
        Set<String>Rating_3500 = Set();
        Set<String>Rating_3600 = Set();
        Set<String>Rating_3700 = Set();
        Set<String>Rating_3800 = Set();
        Set<String>Rating_3900 = Set();
        Set<String>Rating_4000 = Set();


        listResponse?.forEach((element) {

          if(element['verdict'].toString() == "OK" ){
            String temp = element['problem']['contestId'].toString()+element['problem']['name'].toString()+element['problem']['rating'].toString()+ element['problem']['index'].toString();

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
              if(element['problem']['rating'].toString() == "2300"){
              Rating_2300.add(temp);
            }
            if(element['problem']['rating'].toString() == "2400"){
              Rating_2400.add(temp);
            }
            if(element['problem']['rating'].toString() == "2500"){
              Rating_2500.add(temp);
            }
            if(element['problem']['rating'].toString() == "2600"){
              Rating_2600.add(temp);
            }
            if(element['problem']['rating'].toString() == "2700"){
              Rating_2700.add(temp);
            }
            if(element['problem']['rating'].toString() == "2800"){
              Rating_2800.add(temp);
            }
            if(element['problem']['rating'].toString() == "2900"){
              Rating_2900.add(temp);
            }
            if(element['problem']['rating'].toString() == "3000"){
              Rating_3000.add(temp);
            }
            if(element['problem']['rating'].toString() == "3100"){
              Rating_3100.add(temp);
            }
            if(element['problem']['rating'].toString() == "3200"){
              Rating_3200.add(temp);
            }
            if(element['problem']['rating'].toString() == "3300"){
              Rating_2300.add(temp);
            }
            if(element['problem']['rating'].toString() == "3400"){
              Rating_3400.add(temp);
            }
            if(element['problem']['rating'].toString() == "3500"){
              Rating_3500.add(temp);
            }
            if(element['problem']['rating'].toString() == "3600"){
              Rating_3600.add(temp);
            }
            if(element['problem']['rating'].toString() == "3700"){
              Rating_3700.add(temp);
            }
            if(element['problem']['rating'].toString() == "3800"){
              Rating_3800.add(temp);
            }
            if(element['problem']['rating'].toString() == "3900"){
              Rating_3900.add(temp);
            }
            if(element['problem']['rating'].toString() == "4000"){
              Rating_4000.add(temp);
            }

          }else{
            String temp = element['problem']['contestId'].toString()+element['problem']['name'].toString()+element['problem']['rating'].toString()+ element['problem']['index'].toString();
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
      count2300 = Rating_2300.length.toString();
      count2400 = Rating_2400.length.toString();
      count2500 = Rating_2500.length.toString();
      count2600 = Rating_2600.length.toString();
      count2700 = Rating_2700.length.toString();
      count2800 = Rating_2800.length.toString();
      count2900 = Rating_2900.length.toString();
      count3000 = Rating_3000.length.toString();
      count3100 = Rating_3100.length.toString();
      count3200 = Rating_3200.length.toString();
      count3300 = Rating_3300.length.toString();
      count3400 = Rating_3400.length.toString();
      count3500 = Rating_3500.length.toString();
      count3600 = Rating_3600.length.toString();
      count3700 = Rating_3700.length.toString();
      count3800 = Rating_3800.length.toString();
      count3900 = Rating_3900.length.toString();
      count4000 = Rating_4000.length.toString();


      acLen = uniqueCountAC.length.toString();
      int total_attempted = uniqueCountTotal.length;
      int rejected = total_attempted-ac;
      totalAttempted = total_attempted.toString();
      total_rejected = rejected.toString();
      _isLoading = false;
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


            if(worstRank < element['rank']){
              worstRank = element['rank'];
            }
            if(bestRank>element['rank']){
              bestRank = element['rank'];
            }
            int diff = element['newRating']-element['oldRating'];
            if(maxUp<diff) {
              maxUp = diff;
            }
            if(maxDown>diff){
              maxDown = diff;
            }

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
    //if server takes too much time to load data
    Timer(const Duration(seconds: 30), () {
      if(_isLoading == true) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.blueGrey,
                title: const Text(
                    "Sorry!", style: TextStyle(color: Colors.white)),
                content: const Text(
                    "I'm unable to show data,server is not responding..",
                    style: TextStyle(color: Colors.white)),
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
    width = MediaQuery.of(context).size.width/2;
    return Scaffold(
        backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text("User's Statistics"),
        backgroundColor: Colors.black12,
      ),
      body:ListView(
        children: [
          const Center(child : Text("\nProblem Solving",style: TextStyle(fontSize: 15.00, color: Colors.white,fontWeight: FontWeight.bold))),
          const Padding(padding: EdgeInsets.only(top:0,left: 15,right: 15,),child:  Divider(color: Colors.white,thickness: 1,)),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 200,
            child:  ListView(
              children: [
                //total attempted
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        FontAwesomeIcons.personWalkingArrowRight,//circleCheck,
                        color: Colors.white,
                      ),
                      Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width/2,
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
                                  const Text("   "),
                                  Container(
                                      child: acLen != "-1"?Text( "Total Attempted : "+totalAttempted.toString()
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
                    ],),
                ),
                //accepted
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Icon(
                    FontAwesomeIcons.checkToSlot,//circleCheck,
                    color: Colors.green,
                  ),
                  Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width/2,
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
                ],),
                //wrong ans
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      FontAwesomeIcons.xmark,//checkToSlot,//circleCheck,
                      color: Colors.red,
                    ),
                    Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width/2,
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
                                    child: acLen != "-1"? Text("  Rejected : "+total_rejected.toString(),
                                      style: const TextStyle(fontSize: 15.00, color: Colors.white),)
                                        :const Center(child: SpinKitRipple(color: Colors.white,size: 50))
                                )
                              ],
                            )
                        )
                    ),
                  ],
                )

              ],
            ),
          ),

          const Center(child : Text("\nSolve count ",style: TextStyle(fontSize: 15.00, color: Colors.white,fontWeight: FontWeight.bold))),
          const Padding(padding: EdgeInsets.only(top:0,left: 15,right: 15,bottom: 10),child:  Divider(color: Colors.white,thickness: 1,)),

          Container(
            height: 130,
            child:  ListView(
              scrollDirection: Axis.horizontal,
              children: [
                RatingDisplay(rating: 800,count: count800),
                RatingDisplay(rating: 900,count: count900),
                RatingDisplay(rating: 1000,count: count1000),
                RatingDisplay(rating: 1100,count: count1100),
                RatingDisplay(rating: 1200,count: count1200),
                RatingDisplay(rating: 1300,count: count1300),
                RatingDisplay(rating: 1400,count: count1400),
                RatingDisplay(rating: 1500,count: count1500),
                RatingDisplay(rating: 1600,count: count1600),
                RatingDisplay(rating: 1700,count: count1700),
                RatingDisplay(rating: 1800,count: count1800),
                RatingDisplay(rating: 1900,count: count1900),
                RatingDisplay(rating: 2200,count: count2200),
                RatingDisplay(rating: 2300,count: count2300),
                RatingDisplay(rating: 2400,count: count2400),
                RatingDisplay(rating: 2500,count: count2500),
                RatingDisplay(rating: 2600,count: count2600),
                RatingDisplay(rating: 2700,count: count2700),
                RatingDisplay(rating: 2800,count: count2800),
                RatingDisplay(rating: 2900,count: count2900),
                RatingDisplay(rating: 3000,count: count3000),
                RatingDisplay(rating: 3100,count: count3100),
                RatingDisplay(rating: 3200,count: count3200),
                RatingDisplay(rating: 3300,count: count3300),
                RatingDisplay(rating: 3400,count: count3400),
                RatingDisplay(rating: 3500,count: count3500),
                RatingDisplay(rating: 3600,count: count3600),
                RatingDisplay(rating: 3700,count: count3700),
                RatingDisplay(rating: 3800,count: count3800),
                RatingDisplay(rating: 3900,count: count3900),
                RatingDisplay(rating: 4000,count: count4000),
              ],
            ),
          ),
          const Center(child : Text("\nContest summary",style: TextStyle(fontSize: 15.00, color: Colors.white,fontWeight: FontWeight.bold))),
          const Padding(padding: EdgeInsets.only(top:0,left: 15,right: 15,bottom: 10 ),child:  Divider(color: Colors.white,thickness: 1,)),
          //total contest
          Container(
              height: 60,
              width: MediaQuery.of(context).size.width-20,
              margin: const EdgeInsets.only(top:10.00,left: 10,right: 10,bottom: 1),
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
          //contest summary
          Container(
            margin: EdgeInsets.only(top: 15),
            height: 130,
            child:  ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ContestSummary(title: "Best rank",value: bestRank),
                ContestSummary(title: "Worst rank",value: worstRank),
                ContestSummary(title: "Max up",value: maxUp),
                ContestSummary(title: "Max down",value: maxDown),
              ],
            ),
          ),
        ],
      )
    );
  }
}


//Universal code for every Rating display
Widget RatingDisplay({required rating,required count})=>Container(
    height: 130/2,
    width:width,
    margin: const EdgeInsets.all(10.00),
    decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.00),bottomRight: Radius.circular(10.00), topRight: Radius.circular(10.00), bottomLeft: Radius.circular(10.00)), color: Colors.white12,),
    child: Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${rating.toString()} rating : ",style:const TextStyle(fontSize: 15.00,color: Colors.grey)),
            const Padding(
              padding: EdgeInsets.all(5),
              child:  Divider(color: Colors.white,thickness: 1,),
            ),
            Container(child: acLen != "-1"?Text(count.toString(),style: const TextStyle(fontSize: 20.00, color: Colors.white, fontWeight: FontWeight.bold),):const Center(child: SpinKitRipple(color: Colors.white,size: 50)))
          ],
        )
    )
);

Widget ContestSummary({required title,required value})=>Container(
    height: 130/2,
    width:width,
    margin: const EdgeInsets.all(10.00),
    decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.00),bottomRight: Radius.circular(10.00), topRight: Radius.circular(10.00), bottomLeft: Radius.circular(10.00)), color: Colors.white12,),
    child: Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${title.toString()} :",style:const TextStyle(fontSize: 15.00,color: Colors.grey)),
            const Padding(
              padding: EdgeInsets.all(5),
              child:  Divider(color: Colors.white,thickness: 1,),
            ),
            Container(child: acLen != "-1"?Text(value.toString(),style: const TextStyle(fontSize: 20.00, color: Colors.white, fontWeight: FontWeight.bold),):const Center(child: SpinKitRipple(color: Colors.white,size: 50)))
          ],
        )
    )
);
