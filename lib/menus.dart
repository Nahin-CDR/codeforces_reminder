import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'codeforces/contest_list.dart';
import 'codeforces/set_reminder.dart';
import 'codeforces/top_rated.dart';
import 'codeforces/user_contest_list.dart';
import 'codeforces/user_info.dart';
import 'codeforces/user_statistics.dart';
import 'codeforces/user_submission.dart';




class MENUS extends StatefulWidget {
  final String givenHandle;
  MENUS({
    Key? key,
    required this.givenHandle,
  }) : super(key: key);

  @override
  State<MENUS> createState() => _MENUSState(userHandle:givenHandle);
}


List? listResponse;
Map? mapResponse;
bool _loading = true;


class _MENUSState extends State<MENUS> {
  String userHandle;
  _MENUSState({required this.userHandle});
  get HANDLE => userHandle.toString();

  Future ApiCall() async{
    http.Response response;
    response = await http.get(Uri.parse("https://codeforces.com/api/user.info?handles=$userHandle"));
    if(response.statusCode == 200){
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];
      });
      String n = listResponse![0]['country'].toString();
      print(n);

    }else{
      print("error");
    }
    setState((){_loading = false;});

  }




  @override initState(){
    ApiCall();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white12,
          appBar: AppBar(
            backgroundColor: Colors.black12,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Codeforces",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                Text(" Reminder",style: TextStyle(color: Colors.white),)
              ],
            ),
            centerTitle: true,

          ),

          body: MyMenus()//FirstPart(),
      //     _loading? const Center(child: SpinKitRipple(color: Colors.lightBlue,size: 120)) :
      //     Column(
      //       children: [
      //         Row(
      //           children: [
      //             //profile image
      //             Flexible(
      //               flex: 1,
      //               child:  Container(
      //                 margin: const EdgeInsets.all(5),
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(15.00),
      //                   color: Colors.white,
      //                 ),
      //                 child: Center(
      //                   child: listResponse![0]['titlePhoto'] == null ? const Text("Loading data") :
      //                   Container(
      //                     margin: const EdgeInsets.all(5.00),
      //                     width: MediaQuery.of(context).size.width,
      //                     height: 150.00,
      //                     child: const Text(""),
      //                     decoration: BoxDecoration(
      //                         color: Colors.green,
      //                         borderRadius: const BorderRadius.all(Radius.circular(15.00)),
      //                         image: DecorationImage(image: NetworkImage(listResponse![0]['titlePhoto'].toString()),
      //                           fit: BoxFit.fill,
      //                         )
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             Flexible(
      //                 flex: 2,
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Text( listResponse![0]['firstName'].toString(),
      //                       style: TextStyle(
      //                           fontSize: 20.00,
      //                           color: Colors.grey,
      //                           fontWeight: FontWeight.bold),
      //                     ),
      //                     //Country Name
      //                     Container(
      //                       margin: const EdgeInsets.only(top: 10),
      //                       decoration:
      //                       BoxDecoration(borderRadius: BorderRadius.circular(2)),
      //                       child: Center(
      //                         child: listResponse![0]['country'] == null
      //                             ? const Text("Loading data")
      //                             : Text(
      //                           "From : " +
      //                               listResponse![0]['country'].toString(),
      //                           style: const TextStyle(
      //                             fontSize: 15,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     //Contest Rating
      //                     Container(
      //                       margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      //                       decoration:
      //                       BoxDecoration(borderRadius: BorderRadius.circular(2)),
      //                       child: Center(
      //                         child: listResponse![0]['rating'] == null
      //                             ? const Text("Loading data")
      //                             : Text(
      //                           "Contest Rating : " +
      //                               listResponse![0]['rating'].toString(),
      //                           style: const TextStyle(fontSize: 15),
      //                         ),
      //                       ),
      //                     ),
      //                     //MaxRating
      //                     Container(
      //                       margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      //                       decoration:
      //                       BoxDecoration(borderRadius: BorderRadius.circular(2)),
      //                       child: Center(
      //                         child: listResponse![0]['maxRating'] == null
      //                             ? const Text("Loading data")
      //                             : Text(
      //                           "Max Rating : " +
      //                               listResponse![0]['maxRating'].toString(),
      //                           style: const TextStyle(fontSize: 15),
      //                         ),
      //                       ),
      //                     ),
      //                     //Current Rank
      //                     Container(
      //                       margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      //                       decoration:
      //                       BoxDecoration(borderRadius: BorderRadius.circular(2)),
      //                       child: Center(
      //                         child: listResponse![0]['rank'] == null
      //                             ? const Text("Loading data")
      //                             : Text(
      //                           "Current Rank : " +
      //                               listResponse![0]['rank'].toString(),
      //                           style: const TextStyle(fontSize: 15),
      //                         ),
      //                       ),
      //                     ),
      //                     //Max Rank
      //                     Container(
      //                       margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      //                       decoration:
      //                       BoxDecoration(borderRadius: BorderRadius.circular(2)),
      //                       child: Center(
      //                         child: listResponse![0]['maxRank'] == null
      //                             ? const Text("Loading data")
      //                             : Text(
      //                           "Max Rank : " +
      //                               listResponse![0]['maxRank'].toString(),
      //                           style: const TextStyle(fontSize: 15),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 )),
      //
      //
      //           ],
      //         ),
      //     //     Container(
      //     //     height: 150,
      //     //   decoration: const BoxDecoration(
      //     //     borderRadius: BorderRadius.only(
      //     //       bottomRight: Radius.circular(50.00),
      //     //     ),
      //     //     color: Colors.black38,
      //     //   ),
      //     //   child: Stack(
      //     //     children: [
      //     //       Positioned(
      //     //           top:30,
      //     //           left: 0,
      //     //           child:Container(
      //     //
      //     //             child:  Image(
      //     //                 image: NetworkImage(listResponse![0]['titlePhoto'].toString()),
      //     //
      //     //             ),
      //     //             height: 100,
      //     //             width: 200,
      //     //             decoration: const BoxDecoration(
      //     //                 color:Colors.white,
      //     //                 borderRadius: BorderRadius.only(
      //     //                   topRight: Radius.circular(5.00),
      //     //                   bottomRight: Radius.circular(5.00),
      //     //                 )
      //     //
      //     //             ),
      //     //
      //     //           )
      //     //       ),
      //     //       const Positioned(
      //     //           top: 50,
      //     //           left: 10,
      //     //           child: Text(" Menus ",style:
      //     //           TextStyle(fontSize: 30.00, color: Colors.grey, fontWeight: FontWeight.bold),)
      //     //       ),
      //     //     ],
      //     //   ),
      //     // ),
      //         Flexible(
      //             child: SingleChildScrollView(
      //               scrollDirection: Axis.vertical,
      //               child: Column(
      //                 children: [
      //                       //user Profile
      //                       // Container(
      //                       //   margin: EdgeInsets.all(10),
      //                       //   child: InkWell(
      //                       //       borderRadius: const BorderRadius.only(
      //                       //         // topLeft: Radius.circular(50.00),
      //                       //           bottomRight: Radius.circular(5.00)),
      //                       //       onTap: (){
      //                       //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                       //             UserInfo()));
      //                       //       },
      //                       //       child: Ink(
      //                       //         height: MediaQuery.of(context).size.height/12,
      //                       //         width: MediaQuery.of(context).size.width-20,
      //                       //         decoration: const BoxDecoration(
      //                       //             color:Colors.black12,
      //                       //             borderRadius: BorderRadius.only(
      //                       //               // topLeft: Radius.circular(50.00),
      //                       //               bottomRight: Radius.circular(5.00),
      //                       //             )
      //                       //         ),
      //                       //         child:  Container(
      //                       //             child: Center(
      //                       //                 child : Row(
      //                       //                   children: const [
      //                       //                     Text("         "),
      //                       //                     Icon(
      //                       //                       Icons.account_circle_rounded,
      //                       //                       size: 22,
      //                       //                     ),
      //                       //                     Text("  User Profile",style: TextStyle(fontSize: 18.00)),
      //                       //                   ],
      //                       //                 )
      //                       //             )
      //                       //         ),
      //                       //
      //                       //       )
      //                       //   ),
      //                       // ),
      //                       //User Contest List
      //                       Container(
      //                         margin: EdgeInsets.all(10),
      //                         child: InkWell(
      //                             borderRadius: BorderRadius.only(
      //                               // topLeft: Radius.circular(50.00),
      //                                 bottomRight: Radius.circular(5.00)),
      //                             onTap: (){
      //                               Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                                   UserContestList()));
      //                             },
      //                             child: Ink(
      //                               height: MediaQuery.of(context).size.height/12,
      //                               width: MediaQuery.of(context).size.width-20,
      //                               decoration: BoxDecoration(
      //                                   color:Colors.black12,
      //                                   borderRadius: BorderRadius.only(
      //                                     // topLeft: Radius.circular(50.00),
      //                                     bottomRight: Radius.circular(5.00),
      //                                   )
      //                               ),
      //                               child:  Container(
      //                                   child: Center(
      //                                       child : Row(
      //                                         children: const [
      //                                           Text("         "),
      //                                           Icon(
      //                                             Icons.account_tree_outlined,
      //                                             size: 22,
      //                                           ),
      //                                           Text("  User's Contest List",style: TextStyle(fontSize: 18.00)),
      //                                         ],
      //                                       )
      //                                   )
      //                               ),
      //
      //                             )
      //                         ),
      //                       ),
      //                       //User Statistics
      //                       Container(
      //                         margin: EdgeInsets.all(10),
      //                         child: InkWell(
      //                             borderRadius: BorderRadius.only(
      //                               // topLeft: Radius.circular(50.00),
      //                                 bottomRight: Radius.circular(5.00)),
      //                             onTap: (){
      //                               Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                               const UserStatistics()));
      //                             },
      //                             child: Ink(
      //                               height: MediaQuery.of(context).size.height/12,
      //                               width: MediaQuery.of(context).size.width-20,
      //                               decoration: BoxDecoration(
      //                                   color:Colors.black12,
      //                                   borderRadius: BorderRadius.only(
      //                                     //  topLeft: Radius.circular(50.00),
      //                                     bottomRight: Radius.circular(5.00),
      //                                   )
      //                               ),
      //                               child:  Container(
      //                                   child: Center(
      //                                       child : Row(
      //                                         children: const [
      //                                           Text("         "),
      //                                           Icon(
      //                                             Icons.stacked_line_chart,
      //                                             size: 22,
      //                                           ),
      //                                           Text("  User's Statistics",style: TextStyle(fontSize: 18.00)),
      //                                         ],
      //                                       )
      //                                   )
      //                               ),
      //
      //                             )
      //                         ),
      //                       ),
      //                       //User Submissions
      //                       Container(
      //                         margin: EdgeInsets.all(10),
      //                         child: InkWell(
      //                             borderRadius: BorderRadius.only(
      //                               //  topLeft: Radius.circular(50.00),
      //                                 bottomRight: Radius.circular(5.00)),
      //                             onTap: (){
      //                               Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                               const UserSubmission()));
      //                             },
      //                             child: Ink(
      //                               height: MediaQuery.of(context).size.height/12,
      //                               width: MediaQuery.of(context).size.width-20,
      //                               decoration: BoxDecoration(
      //                                   color:Colors.black12,
      //                                   borderRadius: BorderRadius.only(
      //                                     //  topLeft: Radius.circular(50.00),
      //                                     bottomRight: Radius.circular(5.00),
      //                                   )
      //                               ),
      //                               child:  Container(
      //                                   child: Center(
      //                                       child : Row(
      //                                         children: const [
      //                                           Text("         "),
      //                                           Icon(
      //                                             Icons.app_registration,
      //                                             size: 22,
      //                                           ),
      //                                           Text("  User Submissions",style: TextStyle(fontSize: 18.00)),
      //                                         ],
      //                                       )
      //                                   )
      //                               ),
      //
      //                             )
      //                         ),
      //                       ),
      //                       //ContestList
      //                       Container(
      //                         margin: EdgeInsets.all(10),
      //                         child: InkWell(
      //                             splashColor: Colors.green,
      //                             borderRadius: BorderRadius.only(
      //                               //  topLeft: Radius.circular(50.00),
      //                                 bottomRight: Radius.circular(5.00)),
      //                             onTap: (){
      //                               Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                               const ContestList()));
      //                             },
      //                             child: Ink(
      //                               height: MediaQuery.of(context).size.height/12,
      //                               width: MediaQuery.of(context).size.width-20,
      //                               decoration: BoxDecoration(
      //                                   color:Colors.black12,
      //                                   borderRadius: BorderRadius.only(
      //                                     // topLeft: Radius.circular(50.00),
      //                                     bottomRight: Radius.circular(5.00),
      //                                   )
      //                               ),
      //                               child:  Container(
      //                                   child: Center(
      //                                       child : Row(
      //                                         children: const [
      //                                           Text("         "),
      //                                           Icon(
      //                                             Icons.list_alt,
      //                                             size: 22,
      //                                           ),
      //                                           Text("  Contest List ",style: TextStyle(fontSize: 18.00)),
      //                                         ],
      //                                       )
      //                                   )
      //                               ),
      //
      //                             )
      //                         ),
      //                       ),
      //                       //Set Reminder
      //                       Container(
      //                         margin: EdgeInsets.all(10),
      //                         child: InkWell(
      //                             borderRadius: BorderRadius.only(
      //                               //  topLeft: Radius.circular(50.00),
      //                                 bottomRight: Radius.circular(5.00)),
      //                             onTap: (){
      //                               Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                               const SetReminder()));
      //                             },
      //                             child: Ink(
      //                               height: MediaQuery.of(context).size.height/12,
      //                               width: MediaQuery.of(context).size.width-20,
      //                               decoration: BoxDecoration(
      //                                   color:Colors.black12,
      //                                   borderRadius: BorderRadius.only(
      //                                     // topLeft: Radius.circular(50.00),
      //                                     bottomRight: Radius.circular(5.00),
      //                                   )
      //                               ),
      //                               child:  Container(
      //                                   child: Center(
      //                                       child : Row(
      //                                         children: const [
      //                                           Text("         "),
      //                                           Icon(
      //                                             Icons.access_alarm,
      //                                             size: 22,
      //                                           ),
      //                                           Text("  Set Reminder",style: TextStyle(fontSize: 18.00)),
      //                                         ],
      //                                       )
      //                                   )
      //                               ),
      //
      //                             )
      //                         ),
      //                       ),
      //                       //Top rated
      //                       Container(
      //                         margin:const EdgeInsets.all(10),
      //                         child: InkWell(
      //                             borderRadius:const BorderRadius.only(
      //                               //topLeft: Radius.circular(50.00),
      //                                 bottomRight: Radius.circular(5.00)),
      //                             onTap: (){
      //                               Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                               const TopRated()));
      //                             },
      //                             child: Ink(
      //                               height: MediaQuery.of(context).size.height/12,
      //                               width: MediaQuery.of(context).size.width-20,
      //                               decoration:const BoxDecoration(
      //                                   color:Colors.black12,
      //                                   borderRadius: BorderRadius.only(
      //                                     // topLeft: Radius.circular(50.00),
      //                                     bottomRight: Radius.circular(5.00),
      //                                   )
      //                               ),
      //                               child: Center(
      //                                   child : Row(
      //                                     children: const [
      //                                       Text("         "),
      //                                       Icon(
      //                                         Icons.arrow_upward_outlined,
      //                                         size: 22,
      //                                       ),
      //                                       Text("  Top 10 ",style: TextStyle(fontSize: 18.00)),
      //                                     ],
      //                                   )
      //                               ),
      //
      //                             )
      //                         ),
      //                       ),
      //                   //ContestList
      //                   Container(
      //                     margin: EdgeInsets.all(10),
      //                     child: InkWell(
      //                         splashColor: Colors.green,
      //                         borderRadius: BorderRadius.only(
      //                           //  topLeft: Radius.circular(50.00),
      //                             bottomRight: Radius.circular(5.00)),
      //                         onTap: (){
      //                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                           const ContestList()));
      //                         },
      //                         child: Ink(
      //                           height: MediaQuery.of(context).size.height/12,
      //                           width: MediaQuery.of(context).size.width-20,
      //                           decoration: BoxDecoration(
      //                               color:Colors.black12,
      //                               borderRadius: BorderRadius.only(
      //                                 // topLeft: Radius.circular(50.00),
      //                                 bottomRight: Radius.circular(5.00),
      //                               )
      //                           ),
      //                           child:  Container(
      //                               child: Center(
      //                                   child : Row(
      //                                     children: const [
      //                                       Text("         "),
      //                                       Icon(
      //                                         Icons.list_alt,
      //                                         size: 22,
      //                                       ),
      //                                       Text("  Contest List ",style: TextStyle(fontSize: 18.00)),
      //                                     ],
      //                                   )
      //                               )
      //                           ),
      //
      //                         )
      //                     ),
      //                   ),
      //                   //Set Reminder
      //                   Container(
      //                     margin: EdgeInsets.all(10),
      //                     child: InkWell(
      //                         borderRadius: BorderRadius.only(
      //                           //  topLeft: Radius.circular(50.00),
      //                             bottomRight: Radius.circular(5.00)),
      //                         onTap: (){
      //                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                           const SetReminder()));
      //                         },
      //                         child: Ink(
      //                           height: MediaQuery.of(context).size.height/12,
      //                           width: MediaQuery.of(context).size.width-20,
      //                           decoration: BoxDecoration(
      //                               color:Colors.black12,
      //                               borderRadius: BorderRadius.only(
      //                                 // topLeft: Radius.circular(50.00),
      //                                 bottomRight: Radius.circular(5.00),
      //                               )
      //                           ),
      //                           child:  Container(
      //                               child: Center(
      //                                   child : Row(
      //                                     children: const [
      //                                       Text("         "),
      //                                       Icon(
      //                                         Icons.access_alarm,
      //                                         size: 22,
      //                                       ),
      //                                       Text("  Set Reminder",style: TextStyle(fontSize: 18.00)),
      //                                     ],
      //                                   )
      //                               )
      //                           ),
      //
      //                         )
      //                     ),
      //                   ),
      //                   //Top rated
      //                   Container(
      //                     margin:const EdgeInsets.all(10),
      //                     child: InkWell(
      //                         borderRadius:const BorderRadius.only(
      //                           //topLeft: Radius.circular(50.00),
      //                             bottomRight: Radius.circular(5.00)),
      //                         onTap: (){
      //                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                           const TopRated()));
      //                         },
      //                         child: Ink(
      //                           height: MediaQuery.of(context).size.height/12,
      //                           width: MediaQuery.of(context).size.width-20,
      //                           decoration:const BoxDecoration(
      //                               color:Colors.black12,
      //                               borderRadius: BorderRadius.only(
      //                                 // topLeft: Radius.circular(50.00),
      //                                 bottomRight: Radius.circular(5.00),
      //                               )
      //                           ),
      //                           child: Center(
      //                               child : Row(
      //                                 children: const [
      //                                   Text("         "),
      //                                   Icon(
      //                                     Icons.arrow_upward_outlined,
      //                                     size: 22,
      //                                   ),
      //                                   Text("  Top 10 ",style: TextStyle(fontSize: 18.00)),
      //                                 ],
      //                               )
      //                           ),
      //
      //                         )
      //                     ),
      //                   )
      //
      //
      //                 ],
      //               ),
      //             )
      //         ),
      //     // Expanded(
      //     //   child:
      //     // ),
      //   ],
      // ),
    );
  }
}

class MyMenus extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

     return  _loading? const Center(child: SpinKitRipple(color: Colors.white,size: 120)) :
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(7.00),
  
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white12,
                
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      //profile image
                      Flexible(
                        flex: 1,
                        child:  Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.00),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: listResponse![0]['titlePhoto'] == null ? const Text("Loading data") :
                            Container(
                              margin: const EdgeInsets.all(2.00),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/7,
                              child: const Text(""),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: const BorderRadius.all(Radius.circular(15.00)),
                                  image: DecorationImage(image: NetworkImage(listResponse![0]['titlePhoto'].toString()),
                                    fit: BoxFit.fill,
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text( listResponse![0]['firstName'].toString(),
                                style: TextStyle(
                                    fontSize: 20.00,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              //Country Name
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(2)),
                                child: Center(
                                  child: listResponse![0]['country'] == null
                                      ? const Text("Loading data")
                                      : Text(
                                    "From : " +
                                        listResponse![0]['country'].toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                              //Contest Rating
                              Container(
                                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(2)),
                                child: Center(
                                  child: listResponse![0]['rating'] == null
                                      ? const Text("Loading data")
                                      : Text(
                                    "Contest Rating : " +
                                        listResponse![0]['rating'].toString(),
                                    style: const TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                              //MaxRating
                              Container(
                                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(2)),
                                child: Center(
                                  child: listResponse![0]['maxRating'] == null
                                      ? const Text("Loading data")
                                      : Text(
                                    "Max Rating : " +
                                        listResponse![0]['maxRating'].toString(),
                                    style: const TextStyle(fontSize: 15,color: Colors.white),
                                  ),
                                ),
                              ),
                              //Current Rank
                              Container(
                                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(2)),
                                child: Center(
                                  child: listResponse![0]['rank'] == null
                                      ? const Text("Loading data")
                                      : Text(
                                    "Current Rank : " +
                                        listResponse![0]['rank'].toString(),
                                    style: const TextStyle(fontSize: 15,color: Colors.white),
                                  ),
                                ),
                              ),
                              //Max Rank
                              Container(
                                margin: const EdgeInsets.only(top: 10, left: 10, right: 10,bottom: 10),
                                decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(2)),
                                child: Center(
                                  child: listResponse![0]['maxRank'] == null
                                      ? const Text("Loading data")
                                      : Text(
                                    "Max Rank : " +
                                        listResponse![0]['maxRank'].toString(),
                                    style: const TextStyle(fontSize: 15,color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )),

                    ],
                  ),

                ],
              ),
            ),

            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    //User contest List
                    Container(
                      margin: EdgeInsets.all(10),
                      child: InkWell(
                          borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(5.00)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                UserContestList()));
                          },
                          child: Ink(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width-20,
                            decoration: BoxDecoration(
                                color:Colors.black12,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(50.00),
                                  bottomRight: Radius.circular(5.00),
                                )
                            ),
                            child:  Container(
                              color: Colors.white12,
                                child: Center(
                                    child : Row(
                                      children: const [
                                        Text("         "),
                                        Icon(
                                          Icons.account_tree_outlined,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                        Text("  User's Contest List",style: TextStyle(fontSize: 17.00,color: Colors.white)),
                                      ],
                                    )
                                )
                            ),

                          )
                      ),
                    ),
                    //User Statistics
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white12,
                      child: InkWell(
                          borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(5.00)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            const UserStatistics()));
                          },
                          child: Ink(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width-20,
                            decoration: BoxDecoration(
                                color:Colors.black12,
                                borderRadius: BorderRadius.only(
                                  //  topLeft: Radius.circular(50.00),
                                  bottomRight: Radius.circular(5.00),
                                )
                            ),
                            child:  Container(
                                child: Center(
                                    child : Row(
                                      children: const [
                                        Text("         "),
                                        Icon(
                                          Icons.stacked_line_chart,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                        Text("  User's Statistics",style: TextStyle(fontSize: 17.00,color: Colors.white)),
                                      ],
                                    )
                                )
                            ),

                          )
                      ),
                    ),
                    //User Submissions
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white12,
                      child: InkWell(
                          borderRadius: BorderRadius.only(
                            //  topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(5.00)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            const UserSubmission()));
                          },
                          child: Ink(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width-20,
                            decoration: BoxDecoration(
                                color:Colors.black12,
                                borderRadius: BorderRadius.only(
                                  //  topLeft: Radius.circular(50.00),
                                  bottomRight: Radius.circular(5.00),
                                )
                            ),
                            child:  Container(
                                child: Center(
                                    child : Row(
                                      children: const [
                                        Text("         "),
                                        Icon(
                                          Icons.app_registration,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                        Text("  User Submissions",style: TextStyle(fontSize: 17.00,color: Colors.white)),
                                      ],
                                    )
                                )
                            ),

                          )
                      ),
                    ),
                    //ContestList
                    Container(
                      margin: EdgeInsets.all(10),
                      color:Colors.white12,
                      child: InkWell(
                          splashColor: Colors.green,
                          borderRadius: BorderRadius.only(
                            //  topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(5.00)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            const ContestList()));
                          },
                          child: Ink(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width-20,
                            decoration: BoxDecoration(
                                color:Colors.black12,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(50.00),
                                  bottomRight: Radius.circular(5.00),
                                )
                            ),
                            child:  Container(
                                child: Center(
                                    child : Row(
                                      children: const [
                                        Text("         "),
                                        Icon(
                                          Icons.list_alt,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                        Text("  Contest List ",style: TextStyle(fontSize: 17.00,color: Colors.white)),
                                      ],
                                    )
                                )
                            ),

                          )
                      ),
                    ),
                    //Set Reminder
                    Container(
                      color: Colors.white12,
                      margin: EdgeInsets.all(10),
                      child: InkWell(
                          borderRadius: BorderRadius.only(
                            //  topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(5.00)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            const SetReminder()));
                          },
                          child: Ink(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width-20,
                            decoration: BoxDecoration(
                                color:Colors.black12,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(50.00),
                                  bottomRight: Radius.circular(5.00),
                                )
                            ),
                            child:  Container(
                                child: Center(
                                    child : Row(
                                      children: const [
                                        Text("         "),
                                        Icon(
                                          Icons.access_alarm,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                        Text("  Set Reminder",style: TextStyle(fontSize: 17.00,color: Colors.white,)),
                                      ],
                                    )
                                )
                            ),

                          )
                      ),
                    ),
                    //Top rated
                    Container(
                      margin:const EdgeInsets.all(10),
                      color: Colors.white12,
                      child: InkWell(
                          borderRadius:const BorderRadius.only(
                            //topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(5.00)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            const TopRated()));
                          },
                          child: Ink(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width-20,
                            decoration:const BoxDecoration(
                                color:Colors.black12,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(50.00),
                                  bottomRight: Radius.circular(5.00),
                                )
                            ),
                            child: Center(
                                child : Row(
                                  children: const [
                                    Text("         "),
                                    Icon(
                                      Icons.arrow_upward_outlined,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                    Text("  Top 10 ",style: TextStyle(fontSize: 17.00,color: Colors.white,)),
                                  ],
                                )
                            ),

                          )
                      ),
                    ),
                    //ContestList
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white12,
                      child: InkWell(
                          splashColor: Colors.green,
                          borderRadius: BorderRadius.only(
                            //  topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(5.00)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            const ContestList()));
                          },
                          child: Ink(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width-20,
                            decoration: BoxDecoration(
                                color:Colors.black12,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(50.00),
                                  bottomRight: Radius.circular(5.00),
                                )
                            ),
                            child:  Container(
                                child: Center(
                                    child : Row(
                                      children: const [
                                        Text("         "),
                                        Icon(
                                          Icons.list_alt,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                        Text("  Contest List ",style: TextStyle(fontSize: 17.00,color: Colors.white,)),
                                      ],
                                    )
                                )
                            ),

                          )
                      ),
                    ),
                    //Set Reminder
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white12,
                      child: InkWell(
                          borderRadius: BorderRadius.only(
                            //  topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(5.00)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            const SetReminder()));
                          },
                          child: Ink(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width-20,
                            decoration: BoxDecoration(
                                color:Colors.black12,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(50.00),
                                  bottomRight: Radius.circular(5.00),
                                )
                            ),
                            child:  Container(
                                child: Center(
                                    child : Row(
                                      children: const [
                                        Text("         "),
                                        Icon(
                                          Icons.access_alarm,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                        Text("  Set Reminder",style: TextStyle(fontSize: 17.00,color: Colors.white,)),
                                      ],
                                    )
                                )
                            ),

                          )
                      ),
                    ),
                    //Top rated
                    Container(
                      color: Colors.white12,
                      margin:const EdgeInsets.all(10),
                      child: InkWell(
                          borderRadius:const BorderRadius.only(
                            //topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(5.00)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            const TopRated()));
                          },
                          child: Ink(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width-20,
                            decoration:const BoxDecoration(
                                color:Colors.black12,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(50.00),
                                  bottomRight: Radius.circular(5.00),
                                )
                            ),
                            child: Center(
                                child : Row(
                                  children: const [
                                    Text("         "),
                                    Icon(
                                      Icons.arrow_upward_outlined,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                    Text("  Top 10 ",style: TextStyle(fontSize: 17.00,color: Colors.white,)),
                                  ],
                                )
                            ),

                          )
                      ),
                    )
                  ],
                ),
              ),
            ),


      ],
    );
  }

}
class FirstPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.00),
              width: 100.00,
              height: 110.00,
              // ignore: deprecated_member_use
              child: const Icon(
                FontAwesomeIcons.house,
                size: 28,
                color: Colors.white,
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(15.00)),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://th.bing.com/th/id/R.13e5ad26acc4510919b6439954c2c116?rik=QeHPaDx4L2DbaQ&riu=http%3a%2f%2fwallpapercave.com%2fwp%2frJJ8m3y.jpg&ehk=x8t%2f8DKGD9B8%2f00SXjgTom6M3duqRf0jgRC12JxMAd0%3d&risl=&pid=ImgRaw&r=0"),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
                margin: EdgeInsets.all(5.00),
                width: 100.00,
                height: 110.00,
                // ignore: deprecated_member_use
                child: const Icon(
                  FontAwesomeIcons.facebook,
                  size: 28,
                  color: Colors.white,
                ),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(15.00)),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://th.bing.com/th/id/R.13e5ad26acc4510919b6439954c2c116?rik=QeHPaDx4L2DbaQ&riu=http%3a%2f%2fwallpapercave.com%2fwp%2frJJ8m3y.jpg&ehk=x8t%2f8DKGD9B8%2f00SXjgTom6M3duqRf0jgRC12JxMAd0%3d&risl=&pid=ImgRaw&r=0"),
                      fit: BoxFit.fill),
                )),
            Container(
              margin: EdgeInsets.all(5.00),
              width: 100.00,
              height: 110.00,
              child: const Icon(
                FontAwesomeIcons.youtube,
                size: 28,
                color: Colors.white,
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(15.00)),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://th.bing.com/th/id/R.13e5ad26acc4510919b6439954c2c116?rik=QeHPaDx4L2DbaQ&riu=http%3a%2f%2fwallpapercave.com%2fwp%2frJJ8m3y.jpg&ehk=x8t%2f8DKGD9B8%2f00SXjgTom6M3duqRf0jgRC12JxMAd0%3d&risl=&pid=ImgRaw&r=0"),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.00),
              width: 100.00,
              height: 110.00,
              child: const Icon(
                FontAwesomeIcons.twitter,
                size: 28,
                color: Colors.white,
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(15.00)),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://th.bing.com/th/id/R.13e5ad26acc4510919b6439954c2c116?rik=QeHPaDx4L2DbaQ&riu=http%3a%2f%2fwallpapercave.com%2fwp%2frJJ8m3y.jpg&ehk=x8t%2f8DKGD9B8%2f00SXjgTom6M3duqRf0jgRC12JxMAd0%3d&risl=&pid=ImgRaw&r=0"),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.00),
              width: 100.00,
              height: 110.00,
              // ignore: deprecated_member_use
              child: const Icon(
                FontAwesomeIcons.instagram,
                size: 28,
                color: Colors.white,
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(15.00)),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://th.bing.com/th/id/R.13e5ad26acc4510919b6439954c2c116?rik=QeHPaDx4L2DbaQ&riu=http%3a%2f%2fwallpapercave.com%2fwp%2frJJ8m3y.jpg&ehk=x8t%2f8DKGD9B8%2f00SXjgTom6M3duqRf0jgRC12JxMAd0%3d&risl=&pid=ImgRaw&r=0"),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.00),
              width: 100.00,
              height: 110.00,
              // ignore: deprecated_member_use
              child: const Icon(
                FontAwesomeIcons.tiktok,
                size: 28,
                color: Colors.white,
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(15.00)),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://th.bing.com/th/id/R.13e5ad26acc4510919b6439954c2c116?rik=QeHPaDx4L2DbaQ&riu=http%3a%2f%2fwallpapercave.com%2fwp%2frJJ8m3y.jpg&ehk=x8t%2f8DKGD9B8%2f00SXjgTom6M3duqRf0jgRC12JxMAd0%3d&risl=&pid=ImgRaw&r=0"),
                    fit: BoxFit.fill),
              ),
            ),
          ]),
        ),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 250.00,
                  child: Text(""),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(15.00)),
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://image.winudf.com/v2/image/Y29tLmxpdmVwcm8ud2FsbHBhcGVycy53cDIwMjI4X3NjcmVlbnNob3RzXzRfOTBkY2RjYjM/screen-4.jpg?fakeurl=1&type=.jpg",
                          ),
                          fit: BoxFit.fill)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 250.00,
                  child: Text(""),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(15.00)),
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://image.winudf.com/v2/image/Y29tLmxpdmVwcm8ud2FsbHBhcGVycy53cDIwMjI4X3NjcmVlbnNob3RzXzRfOTBkY2RjYjM/screen-4.jpg?fakeurl=1&type=.jpg",
                          ),
                          fit: BoxFit.fill)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 250.00,
                  child: Text(""),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(15.00)),
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://image.winudf.com/v2/image/Y29tLmxpdmVwcm8ud2FsbHBhcGVycy53cDIwMjI4X3NjcmVlbnNob3RzXzRfOTBkY2RjYjM/screen-4.jpg?fakeurl=1&type=.jpg",
                          ),
                          fit: BoxFit.fill)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 250.00,
                  child: Text(""),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(15.00)),
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://image.winudf.com/v2/image/Y29tLmxpdmVwcm8ud2FsbHBhcGVycy53cDIwMjI4X3NjcmVlbnNob3RzXzRfOTBkY2RjYjM/screen-4.jpg?fakeurl=1&type=.jpg",
                          ),
                          fit: BoxFit.fill)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 250.00,
                  child: Text(""),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(15.00)),
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://image.winudf.com/v2/image/Y29tLmxpdmVwcm8ud2FsbHBhcGVycy53cDIwMjI4X3NjcmVlbnNob3RzXzRfOTBkY2RjYjM/screen-4.jpg?fakeurl=1&type=.jpg",
                          ),
                          fit: BoxFit.fill)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 250.00,
                  child: Text(""),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(15.00)),
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://image.winudf.com/v2/image/Y29tLmxpdmVwcm8ud2FsbHBhcGVycy53cDIwMjI4X3NjcmVlbnNob3RzXzRfOTBkY2RjYjM/screen-4.jpg?fakeurl=1&type=.jpg",
                          ),
                          fit: BoxFit.fill)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}