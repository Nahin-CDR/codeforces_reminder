import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
class UserStats extends StatefulWidget {

  final String id;
  final int count800;
  final int count900;
  final int count1000;
  final int count1100;
  final int count1200;
  final int count1300;
  final int count1400;
  final int count1500;
  final int count1600;
  final int count1700;
  final int count1800;
  final int count1900;
  final int count2200;
  final int count2300;
  final int count2400;
  final int count2500;
  final int count2600;
  final int count2700;
  final int count2800;
  final int count2900;
  final int count3000;
  final int count3100;
  final int count3200;
  final int count3300;
  final int count3400;
  final int count3500;
  final int count3600;
  final int count3700;
  final int count3800;
  final int count3900;
  final int count4000;
  UserStats({
    Key? key,
    required this.id,
    required this.count800,
    required this.count900,
    required this.count1000,
    required this.count1100,
    required this.count1200,
    required this.count1300,
    required this.count1400,
    required this.count1500,
    required this.count1600,
    required this.count1700,
    required this.count1800,
    required this.count1900,
    required this.count2200,
    required this.count2300,
    required this.count2400,
    required this.count2500,
    required this.count2600,
    required this.count2700,
    required this.count2800,
    required this.count2900,
    required this.count3000,
    required this.count3100,
    required this.count3200,
    required this.count3300,
    required this.count3400,
    required this.count3500,
    required this.count3600,
    required this.count3700,
    required this.count3800,
    required this.count3900,
    required this.count4000,
  }) : super(key: key);


  @override
  State<UserStats> createState() =>_UserStatsState(
      userHandle: id,
      count800: count800,
      count900: count900,
      count1000: count1000,
      count1100: count1100,
      count1200 : count1200,
      count1300 : count1300,
      count1400 : count1400,
      count1500 : count1500,
      count1600 : count1600,
      count1700 : count1700,
      count1800 : count1800,
      count1900 : count1900,
      count2200:count2200,
      count2300:count2300,
    count2400:count2400,
    count2500:count2500,
    count2600:count2600,
    count2700:count2700,
    count2800:count2800,
    count2900:count2900,
    count3000:count3000,
    count3100:count3100,
    count3200:count3200,
    count3300:count3300,
    count3400:count3400,
    count3500:count3500,
    count3600:count3600,
    count3700:count3700,
    count3800:count3800,
    count3900:count3900,
    count4000:count4000,
  );
}

String problemCount = "50";

List? listResponse;
Map? mapResponse;
Map? accepted;
String? acLen = "-1";
String? totalAttempted = "-1";
String? total_rejected = "-1";

Map? ContestCountmp;
List? ContestCountList;












int bestRank = 999999999;
int worstRank = 0;
int maxUp = 0;
int maxDown = 999999999;

String? contestCount = "0";
double? width;
bool _isLoading = true;
class _UserStatsState extends State<UserStats> {

  String userHandle;
  int count800;
  int count900;
  int count1000;
  int count1100;
  int count1200;
  int count1300;
  int count1400;
  int count1500;
  int count1600;
  int count1700;
  int count1800;
  int count1900;
  int count2200;
  int count2300;
  int count2400;
  int count2500;
  int count2600;
  int count2700;
  int count2800;
  int count2900;
  int count3000;
  int count3100;
  int count3200;
  int count3300;
  int count3400;
  int count3500;
  int count3600;
  int count3700;
  int count3800;
  int count3900;
  int count4000;
  _UserStatsState({
    required this.userHandle,
    required this.count800,
    required this.count900,
    required this.count1000,
    required this.count1100,
    required this.count1200,
    required this.count1300,
    required this.count1400,
    required this.count1500,
    required this.count1600,
    required this.count1700,
    required this.count1800,
    required this.count1900,
    required this.count2200,
    required this.count2300,
    required this.count2400,
    required this.count2500,
    required this.count2600,
    required this.count2700,
    required this.count2800,
    required this.count2900,
    required this.count3000,
    required this.count3100,
    required this.count3200,
    required this.count3300,
    required this.count3400,
    required this.count3500,
    required this.count3600,
    required this.count3700,
    required this.count3800,
    required this.count3900,
    required this.count4000,

  });
  get ID => userHandle.toString();
  get r1=> count800.toInt();
  get r2=>count900.toInt();
  get r3=>count1000.toInt();
  get r4=>count1100.toInt();
  get r5=>count1200.toInt();
  get r6=>count1300.toInt();
  get r7=>count1400.toInt();
  get r8=>count1500.toInt();
  get r9=>count1600.toInt();
  get r10=>count1700.toInt();
  get r11=>count1800.toInt();
  get r12=>count1900.toInt();
  get r13=>count2200.toInt();
  get r14=>count2300.toInt();
  get r15=>count2400.toInt();
  get r16=>count2500.toInt();
  get r17=>count2600.toInt();
  get r18=>count2700.toInt();
  get r19=>count2800.toInt();
  get r20=>count2900.toInt();
  get r21=>count3000.toInt();
  get r22=>count3100.toInt();
  get r23=>count3200.toInt();
  get r24=>count3300.toInt();
  get r25=>count3400.toInt();
  get r26=>count3500.toInt();
  get r27=>count3600.toInt();
  get r28=>count3700.toInt();
  get r29=>count3800.toInt();
  get r30=>count3900.toInt();
  get r31=>count4000.toInt();

  Future ApiCall() async{

    bestRank = 999999999;
    worstRank = 0;
    maxUp = 0;
    maxDown = 999999999;

    http.Response response1,response2;
    response1 = await http.get(Uri.parse("https://codeforces.com/api/user.status?handle=$userHandle"));
    response2 = await http.get(Uri.parse("https://codeforces.com/api/user.rating?handle=$userHandle"));
    //print(response1.statusCode);
    if(response1.statusCode == 200){
      setState(() {
        mapResponse = json.decode(response1.body);
        listResponse = mapResponse!['result'];
        Set<String>uniqueCountAC = Set();
        Set<String>uniqueCountTotal = Set();

        listResponse?.forEach((element) {
          if(element['verdict'].toString() == "OK" ){
            String temp = element['problem']['contestId'].toString()+element['problem']['name'].toString()+element['problem']['rating'].toString()+ element['problem']['index'].toString();
              uniqueCountAC.add(temp);
              uniqueCountTotal.add(temp);
          }else{
            String temp = element['problem']['contestId'].toString()+element['problem']['name'].toString()+element['problem']['rating'].toString()+ element['problem']['index'].toString();
            uniqueCountTotal.add(temp);
          }
        });

      int ac = uniqueCountAC.length;
      acLen = uniqueCountAC.length.toString();
      int total_attempted = uniqueCountTotal.length;
      int rejected = total_attempted-ac;
      totalAttempted = total_attempted.toString();
      total_rejected = rejected.toString();

      });

    }else{
     // print("Error");
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
        _isLoading = false;

      });
    }
    contestCount = number_of_contest.length.toString();



  }
  //call this ApiCall() method at first when u come to this page

  //code for graph
  late List<charts.Series<Ratings, String>> _seriesData;
  _generateData() {
    var data1 = [
      Ratings('800',r1),
      Ratings('900', r2),
      Ratings('1000', r3),
      Ratings('1100', r4),
      Ratings('1200', r5),
      Ratings('1300', r6),
      Ratings('1400', r7),
      Ratings('1500', r8),
      Ratings('1600', r9),
      Ratings('1700', r10),
      Ratings('1800', r11),
      Ratings('1900', r12),
      Ratings('2200', r13),
      Ratings('2300', r14),
      Ratings('2400', r15),
      Ratings('2500', r16),
      Ratings('2600', r17),
      Ratings('2700', r18),
      Ratings('2800', r19),
      Ratings('2900', r20),
      Ratings('3000', r21),
      Ratings('3100', r22),
      Ratings('3200', r23),
      Ratings('3300', r24),
      Ratings('3400', r25),
      Ratings('3500', r26),
      Ratings('3600', r27),
      Ratings('3700', r28),
      Ratings('3800', r29),
      Ratings('3900', r30),
      Ratings('4000', r31),
    ];
    _seriesData.add(
      charts.Series(
        domainFn: (Ratings base, _) => base.base_rating,
        measureFn: (Ratings solveCount,_) => solveCount.solved,
        id: '01',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Ratings pollution, _) => charts.ColorUtil.fromDartColor(
            Colors.white),
      ),
    );

  }
  @override
  void initState() {
    // TODO: implement initState
    ApiCall();
    super.initState();

    _seriesData = <charts.Series<Ratings, String>>[];
    _generateData();



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
      body:_isLoading? Center(child: SpinKitRipple(color: Colors.white,size: 120)):
      ListView(
        children: [

          Container(
              height: 20,
              alignment: Alignment.center,
              margin:const EdgeInsets.only(top: 10),
              child:const Text("Solve count graph",style: TextStyle(color: Colors.white,fontSize: 15))),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 10),
            child: Container(
              height: MediaQuery.of(context).size.height/2,
              width: 1500.0,
              child:Container(
                //flex: 1,
                //fit: FlexFit.loose,
                child: charts.BarChart(
                  _seriesData,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.grouped,
                  // behaviors: [charts.SeriesLegend()],
                  animationDuration:const Duration(seconds: 5),
                  domainAxis :const charts.OrdinalAxisSpec(
                      renderSpec: charts.GridlineRendererSpec(
                        labelStyle: charts.TextStyleSpec(
                            fontSize: 12, color: charts.MaterialPalette.white
                        ), //change white color as per your requirement.
                      )),
                  primaryMeasureAxis:const  charts.NumericAxisSpec(
                      renderSpec: charts.GridlineRendererSpec(
                        labelStyle: charts.TextStyleSpec(
                            fontSize: 10, color: charts.MaterialPalette.white
                        ), //change white color as per your requirement.
                      )),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 20,
                  alignment: Alignment.center,
                  margin:const EdgeInsets.only(top: 10),
                  child:const Text("Problem Ratings ",style: TextStyle(color: Colors.white,fontSize: 15))),
              Container(
                  height: 20,
                  alignment: Alignment.bottomRight,
                  margin:const EdgeInsets.only(top: 10),
                  child:const Text(" >",style: TextStyle(color: Colors.white,fontSize: 15))),
            ],
          ),
          Padding(padding: EdgeInsets.only(top:0,left: 15,right: 15,bottom: 10),child:  Divider(color: Colors.white,thickness: 1,)),

          //google chart end
          //---------------------------------------------------
          Center(child :
          Text("\nProblem Solving", style: TextStyle(fontSize: 15.00, color: Colors.white,fontWeight: FontWeight.bold))),

          Padding(padding: EdgeInsets.only(top:0,left: 15,right: 15,),child:  Divider(color: Colors.white,thickness: 1,)),

          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  //Colors.red,
                  Color.fromRGBO(32, 50, 93, 0.5),
                  Color.fromRGBO(32, 50, 93, 0.5),
                  Color.fromRGBO(32, 50, 93, 0.5),
                  Color.fromRGBO(32, 50, 93, 0.5)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.2, 0.8, 1],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
           // color: const Color.fromRGBO(142, 142, 142, 0.5019607843137255),
            margin: const EdgeInsets.all(10),
            height: 150,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //total attempted
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text( "Total Attempted : ",style:TextStyle(fontSize: 15.00,color: Colors.white)),
                    acLen != "-1"?Text(totalAttempted.toString()
                      ,style:const TextStyle(
                          fontSize: 20.00,
                          color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ):const
                    Center(child: SpinKitRipple(color: Colors.white,size: 50))
                  ],
                ),
                //accepted
                Container(
                    margin:const EdgeInsets.only(top: 10,bottom: 10),
                    child :  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Text(" Accepted : ",style:TextStyle(fontSize: 15.00, color: Colors.white)),
                        acLen != "-1"?Text(acLen.toString(),
                          style:const TextStyle(fontSize: 20.00, color: Colors.white,fontWeight: FontWeight.bold))
                            :const Center(
                            child: SpinKitRipple(color: Colors.white,size: 50))
                      ],
                    )
                ),
                //wrong ans
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text( " Rejected : ",style:TextStyle(fontSize: 15.00,color: Colors.white)),
                    acLen != "-1"?Text(total_rejected.toString()
                      ,style:const TextStyle(
                          fontSize: 20.00,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ):const
                    Center(child: SpinKitRipple(color: Colors.white,size: 50))
                  ],
                ),

              ],
            ),
          ),

           Center(child : Text("\nSolve count ",style: TextStyle(fontSize: 15.00, color: Colors.white,fontWeight: FontWeight.bold))),
           Padding(padding: EdgeInsets.only(top:0,left: 15,right: 15,bottom: 10),child:  Divider(color: Colors.white,thickness: 1,)),

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
           Center(child : Text("\nContest summary",style: TextStyle(fontSize: 15.00, color: Colors.white,fontWeight: FontWeight.bold))),
           Padding(padding: EdgeInsets.only(top:0,left: 15,right: 15,bottom: 10 ),child:  Divider(color: Colors.white,thickness: 1,)),
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
      ),

    );
  }
}


//Universal code for every Rating display
Widget RatingDisplay({required rating,required count})=>Container(
    height: 130/2,
    width:width,
    margin: const EdgeInsets.all(10.00),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.00),bottomRight: Radius.circular(10.00),
          topRight: Radius.circular(10.00), bottomLeft: Radius.circular(10.00)),
          color: const Color.fromRGBO(32, 50, 93, .50)),
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
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.00),
          bottomRight: Radius.circular(10.00),
          topRight: Radius.circular(10.00),
          bottomLeft: Radius.circular(10.00)),
      color: const Color.fromRGBO(32, 50, 93, .50),),
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

class Ratings {
  String base_rating;
  int solved;
  Ratings( this.base_rating, this.solved);
}
